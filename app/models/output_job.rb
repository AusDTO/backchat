class OutputJob < ActiveRecord::Base
  belongs_to :output
  belongs_to :submission
  has_one :form, through: :submission

  def run
    self.output.run(self.submission)
  end
end