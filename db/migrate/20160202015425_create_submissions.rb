
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
      t.binary 'file'
      t.string 'file_type'
      t.jsonb 'content'

    end
    add_reference :submissions ,:form, type: :uuid, index: true, foreign_key: true
  end
end
