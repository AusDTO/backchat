
class CreateForms < ActiveRecord::Migration
  def up
    execute <<-SQL
      CREATE extension IF NOT EXISTS pgcrypto;
    SQL
  end
  def change
    create_table :forms, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.string 'name', required: true
      t.string 'website',  required: true
      t.jsonb 'input_fields'
      t.references :owner, class_name: "User", index: true, required: true
    end
  end
end
