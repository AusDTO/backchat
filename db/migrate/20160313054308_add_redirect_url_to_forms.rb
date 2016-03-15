class AddRedirectUrlToForms < ActiveRecord::Migration
  def change
    add_column :forms, :redirect_url, :string
  end
end
