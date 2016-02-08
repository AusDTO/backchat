class Output < ActiveRecord::Base
 belongs_to :user
 belongs_to :form
 has_many :output_jobs

  def to_s
   self.name
  end
end

class ZendeskOutput < Output

end
# https://developers.google.com/gmail/api/quickstart/ruby
class GmailOutput < Output

end
class GoogleSheetOutput < Output

end