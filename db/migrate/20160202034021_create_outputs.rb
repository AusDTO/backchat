class CreateOutputs < ActiveRecord::Migration[4.2]
  def change
    create_table :outputs, id: :string do |t|
      t.string :name, required: true
      t.jsonb 'configuration', required: true
      t.string :type, equired: true
      t.references :owner, class_name: "User", index: true, required: true
    end
    create_table :forms_outputs, id: false do |t|
      t.belongs_to :output, type: :string, index: true
      t.belongs_to :form, type: :string, index: true
    end
    create_table :output_jobs, id: :string do |t|
      t.references :output, type: :string, index: true, required: true
      t.references :submission, type: :string, index: true, required: true
      t.boolean 'success'
      t.jsonb 'result'
      t.timestamps
    end
  end
end
