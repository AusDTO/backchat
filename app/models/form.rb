class Form < ActiveRecord::Base
  belongs_to :user
  has_many :submissions
  has_many :outputs

  def satisfaction_avg
    submissions.average(:satisfaction)
  end

  def submissions_count
    submissions.count()
  end
end