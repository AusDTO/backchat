class Output < ActiveRecord::Base
 belongs_to :user
 belongs_to :form
 has_many :output_jobs

  def to_s
   self.name
  end
  def run
   raise 'No output run code defined'
  end
end


