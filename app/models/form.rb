class Form < ActiveRecord::Base
  belongs_to :user
  has_many :submissions
  has_many :outputs

end