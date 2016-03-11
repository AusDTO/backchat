class OutputJob < ActiveRecord::Base
  belongs_to :output
  belongs_to :submission
  has_one :form, through: :submission
  before_create :generate_uuid, unless: :id

  def generate_uuid
    self.id = SecureRandom.uuid
  end

  def to_s
    self.submission_id[0, 8] + '-' + self.output.to_s + ' ' + self.created_at.to_s(:default)
  end

  def run
    r = self.output.run(self.submission)
    self.success = r['success']
    self.result = r['result']
    r
  end
end