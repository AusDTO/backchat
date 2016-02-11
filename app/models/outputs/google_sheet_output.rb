# https://developers.google.com/google-apps/spreadsheets/#adding_a_list_row
class GoogleSheetOutput < Output
  def run
    begin
      {"success" => false, "result" => {'msg' => "did not run"}.to_json}
    rescue Exception => e
      {"success" => false, "result" => {'msg' => e.message, 'trace' => e.backtrace.inspect}.to_json}
    end
  end
end