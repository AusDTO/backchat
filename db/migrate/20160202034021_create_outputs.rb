class CreateOutputs < ActiveRecord::Migration
  def up
    execute <<-SQL
      CREATE extension IF NOT EXISTS pgcrypto;
    SQL
  end
  def change
    create_table :outputs, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.string :name, required: true
      t.jsonb 'configuration'
      t.string :type,  required: true
      t.references :owner, class_name: "User", index: true, required: true
      t.references :form, index: true, required: true
    end

    create_join_table :outputs, :submissions, table_name: 'output_jobs' do |t|
      t.boolean 'success'
      t.jsonb 'result'
      t.timestamps
    end
  end
end
