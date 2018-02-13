
class CreateForms < ActiveRecord::Migration[4.2]
  def change
    create_table :forms, id: :string do |t|
      t.string 'name', required: true
      t.string 'website',  required: true
      t.string 'redirect_url'
      t.boolean 'allow_file'
      t.jsonb 'input_fields'
      t.references :owner, class_name: "User", index: true, required: true
    end
  end
end
