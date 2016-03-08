require 'google/apis/gmail_v1'
require 'googleauth'
require 'mail'
require 'time'
   Gmail = Google::Apis::GmailV1
      gmail = Gmail::GmailService.new
creds =
  {
    "id" => 4,
    "user_id" => 6,
    "provider" => "google",
    "uid" => "112579334383644088510",
    "access_token" => "ya29.hAJL1BSwNYMuRsDCa3a6q8bZNDrOUGLgvauW_PtuxqBWLKDLkVVR18oIuwCaw_LB3Vdf",
    "refresh_token" => "1/0_jmQ778pLsvAISYpNibd1z2PqNqEMsgCSfbhyaTs4NIgOrJDtdun6zK6XiATCKT",
    "expires_at" => "2016-02-10 04:09:12.575587",
    "created_at" => "2016-02-10 00:54:24.149700",
    "updated_at" => "2016-02-10 03:09:12.582668",
    "scope" =>"email, profile, gmail.send, drive.file"
  }
user_credentials = Google::Auth::UserRefreshCredentials.new(
    client_id: ENV["GOOGLE_CLIENT_ID"],
    client_secret:  ENV["GOOGLE_CLIENT_SECRET"],
    scope: creds['scope'],
    access_token: creds['access_token'],
    refresh_token: creds['refresh_token'],
    expires_at: Time.parse(creds['expires_at']).to_i)
      gmail.authorization = user_credentials



mail = Mail.new do
  from 'no-reply@digital.gov.au'
  to 'maxious@gmail.com'
  subject 'This is a test email'
  body 'hello'
  #body File.read('body.txt')
end

result = gmail.send_user_message('me',
                              upload_source: StringIO.new(mail.to_s),
                              content_type: 'message/rfc822')

puts result