class Output < ActiveRecord::Base
  belongs_to :owner, :class_name => "User"
  has_and_belongs_to_many :forms
  has_many :output_jobs

  validates :name, :type, presence: true
  before_create :generate_uuid, unless: :id

  attribute :configuration, :jsonb, default: {}
  def generate_uuid
    self.id = SecureRandom.uuid
  end

  def to_s
    self.name
  end

  def run
    raise 'No output run code defined'
  end
end