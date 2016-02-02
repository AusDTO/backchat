
class CreateForms < ActiveRecord::Migration
  def up
    execute <<-SQL
      CREATE extension IF NOT EXISTS pgcrypto;
    SQL
  end
  def change
    create_table :forms, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.string 'website'
      t.jsonb 'input_fields'
    end
  end
end
