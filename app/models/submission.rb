class Submission < ActiveRecord::Base
  belongs_to :form
  #has_many :output_jobs
  rails_admin do
    object_label_method do
      "#{self.id}"
    end
    list do
      configure :updated_at do
        hide
      end
      configure :updated_at do
        hide
      end
      configure :file_type do
        hide
      end
    end
  end
end