class OutputJob < ActiveRecord::Base
  belongs_to :output
  belongs_to :submission
  has_one :form, through: :submission

  def to_s
    self.submission_id[0,8] + '-' + self.output.to_s + ' ' + self.created_at.to_s(:default)
  end
  def run
    self.output.run(self.submission)
  end
end