
class CreateSubmissions < ActiveRecord::Migration
  def up
    execute <<-SQL
      CREATE extension IF NOT EXISTS pgcrypto;
    SQL
  end
  def change
    create_table :submissions, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.timestamps
      t.string 'path'
      t.decimal 'satisfaction', precision: 3, scale: 0
      t.string 'file_id'
      t.jsonb 'content', required: true
      t.references :form, type: :uuid, index: true, required: true
    end
  end
end
