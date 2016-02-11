class CreateOutputs < ActiveRecord::Migration
  def change
    enable_extension 'pgcrypto'
    create_table :outputs, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.string :name, required: true
      t.jsonb 'configuration', required: true
      t.string :type,  required: true
      t.references :owner, class_name: "User", index: true, required: true
      t.references :form, type: :uuid, index: true, required: true
    end

    create_table :output_jobs, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.references :output, type: :uuid, index: true, required: true
      t.references :submission, type: :uuid, index: true, required: true
      t.boolean 'success'
      t.jsonb 'result'
      t.timestamps
    end
  end
end
