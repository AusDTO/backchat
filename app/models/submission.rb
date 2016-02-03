class Submission < ActiveRecord::Base
  belongs_to :form
  rails_admin do
    object_label_method do
      "#{self.id}"
    end
  end
end