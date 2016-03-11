
class CreateForms < ActiveRecord::Migration
  def change
    create_table :forms, id: :string do |t|
      t.string 'name', required: true
      t.string 'website',  required: true
      t.jsonb 'input_fields'
      t.references :owner, class_name: "User", index: true, required: true
    end
  end
end
