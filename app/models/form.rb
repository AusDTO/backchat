class Form < ActiveRecord::Base
  belongs_to :user
  has_many :submissions
  has_many :outputs
  rails_admin do
    # https://github.com/sferik/rails_admin/wiki/Fields
    edit do
      group :default do
        label "Form information"
        help "Please fill all information related to your form..."
        field :name do
          label "Title"
        end
        field :website do
          label "Website/Property"
        end
        field :outputs do
          label "Outputs"
          help "Outputs enabled for use with this form"
        end
        # you need to tell RailsAdmin that you want to use an `:enum` field
        field :owner_id, :enum do

          # if you need select the default value
          default_value do
            bindings[:view]._current_user.id
          end

          enum do
            if bindings[:view]._current_user.admin
              User.all.map { |c| [c.name, c.id] }
            else
              uid = bindings[:view]._current_user.id
              User.where('id = ?', uid).map { |c| [c.name, c.id] }
            end
          end

        end
      end
    end
    list do
      configure :submissions do
        hide
      end
    end

  end
end