
class CreateSubmissions < ActiveRecord::Migration
  def change

    create_table :submissions, id: :string do |t|
      t.timestamps
      t.string 'path'
      t.decimal 'satisfaction', precision: 3, scale: 0
      t.string 'file_id'
      t.jsonb 'content', required: true
      t.references :form, type: :string, index: true, required: true
    end
  end
end
