class Submission < ActiveRecord::Base
  belongs_to :form
  has_many :output_jobs
  attachment :file
end