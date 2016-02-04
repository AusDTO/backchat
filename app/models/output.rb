class Output < ActiveRecord::Base
belongs_to :user
  belongs_to :form
has_many :output_jobs
end

class ZenDeskOutput < Output

end
# https://developers.google.com/gmail/api/quickstart/ruby
class GmailOutput < Output

end
class SheetOutput < Output

end