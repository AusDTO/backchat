class OutputJob < ActiveRecord::Base
  belongs_to :output
  belongs_to :submission
end