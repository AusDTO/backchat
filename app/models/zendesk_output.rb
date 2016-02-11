class ZendeskOutput < Output
  def run (submission)
    '''  "ticket": {
    "subject": subject,

    "comment": {"body": description}'''
    begin
      {"success" => false, "result" => {'msg' => "did not run"}.to_json}
    rescue Exception => e
      {"success" => false, "result" => {'msg' => e.message, 'trace' => e.backtrace.inspect}.to_json}
    end
  end
end