class CreateIdentities < ActiveRecord::Migration
  def change
    create_table :identities do |t|
      t.references :user, index: true
      t.string :provider
      t.string :uid
      t.string :id_token
      t.string :access_token
      t.string :refresh_token
      t.string :scope
      t.datetime :expires_at
      t.timestamps
    end
  end
end
