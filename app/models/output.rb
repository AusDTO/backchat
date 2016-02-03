class Output < ActiveRecord::Base
belongs_to :form
end

class ZenDeskOutput < Output

end
# https://developers.google.com/gmail/api/quickstart/ruby
class GmailOutput < Output

end
class SheetOutput < Output

end