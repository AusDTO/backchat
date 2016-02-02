class CreateOutputs < ActiveRecord::Migration
  def up
    execute <<-SQL
      CREATE extension IF NOT EXISTS pgcrypto;
    SQL
  end
  def change
    create_table :outputs, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.jsonb 'configuration'
      t.string :type
    end
    add_reference :outputs, :form, type: :uuid, index: true, foreign_key: true
    create_join_table :outputs, :submissions, table_name: 'output_jobs' do |t|
      t.boolean 'success'
      t.jsonb 'result'
      t.timestamps
    end
  end
end
