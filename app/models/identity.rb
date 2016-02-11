require 'net/http'
require 'json'
require 'googleauth'

class Identity < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :uid, :provider, :user_id
  validates_uniqueness_of :uid, :scope => :provider

  def self.find_for_oauth(auth)
    if auth.provider == 'google'
      find_or_create_by(uid: auth.uid, provider: auth.provider)
    else
      find_or_create_by(uid: auth.id, provider: auth.provider)
    end

  end

  def to_params
    {'refresh_token' => refresh_token,
     'client_id' => ENV["GOOGLE_CLIENT_ID"],
     'client_secret' => ENV["GOOGLE_CLIENT_SECRET"],
     'grant_type' => 'refresh_token'}
  end

  def request_token_from_google
    url = URI("https://accounts.google.com/o/oauth2/token")
    Net::HTTP.post_form(url, self.to_params)
  end

  def refresh!
    response = request_token_from_google
    data = JSON.parse(response.body)
    update_attributes(
        access_token: data['access_token'],
        expires_at: Time.now + (data['expires_in'].to_i).seconds)
  end

  def expired?
    expires_at < Time.now
  end

  def fresh_token
    refresh! if expired?
    access_token
  end

  def as_user_creds
    fresh_token
    Google::Auth::UserRefreshCredentials.new(
        client_id: ENV["GOOGLE_CLIENT_ID"],
        client_secret: ENV["GOOGLE_CLIENT_SECRET"],
        scope: scope,
        access_token: access_token,
        refresh_token: refresh_token,
        expires_at: expires_at.to_i)
  end
end
