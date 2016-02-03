class Output < ActiveRecord::Base
has_many :forms
belongs_to :user
end

class ZenDeskOutput < Output

end
# https://developers.google.com/gmail/api/quickstart/ruby
class GmailOutput < Output

end
class SheetOutput < Output

end