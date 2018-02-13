class CreateGlobalConfigs < ActiveRecord::Migration[4.2]
  def change
    create_table :global_configs do |t|

    	t.string :app_name
    	t.string :app_domain

    	t.string :facebook_app_id
    	t.string :twitter_app_id
    	t.string :linkedin_app_id

    	t.boolean :use_slack, :default => false
    	t.string :slack_team
    	t.string :slack_icon_url
    	t.string :slack_user

      t.timestamps
    end
  end
end