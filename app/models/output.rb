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

class ZendeskOutput < Output
 def run
  begin
   {"success" => false, "result" => {'msg' => "did not run"}.to_json}
  rescue Exception => e
   {"success" => false, "result" => {'msg' => e.message, 'trace' => e.backtrace.inspect}.to_json}
  end
 end
end

# https://developers.google.com/gmail/api/quickstart/ruby
class GmailOutput < Output
 def run
  begin
   {"success" => false, "result" => {'msg' => "did not run"}.to_json}
  rescue Exception => e
   {"success" => false, "result" => {'msg' => e.message, 'trace' => e.backtrace.inspect}.to_json}
  end
 end
end

class GoogleSheetOutput < Output
 def run
  begin
   {"success" => false, "result" => {'msg' => "did not run"}.to_json}
  rescue Exception => e
   {"success" => false, "result" => {'msg' => e.message, 'trace' => e.backtrace.inspect}.to_json}
  end
 end
end