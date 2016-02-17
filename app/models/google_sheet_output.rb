# https://developers.google.com/google-apps/spreadsheets/#adding_a_list_row
# https://github.com/gimite/google-drive-ruby
class GoogleSheetOutput < Output
  def run (submission)
    begin
      session = GoogleDrive.login_with_oauth(self.owner.identity.as_user_cred.access_token)
      {"success" => false, "result" => {'msg' => "did not run"}.to_json}
    rescue Exception => e
      {"success" => false, "result" => {'msg' => e.message, 'trace' => e.backtrace.inspect}.to_json}
    end
  end
end