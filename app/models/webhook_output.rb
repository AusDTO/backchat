require 'rest-client'
class WebhookOutput < Output
  def run (submission)
    begin
      url = self.configuration["webhook_url"]

      headers = {"Content-Type" => 'application/json', "Accept" => 'application/json'}

      result = RestClient.post(url, submission.to_json, headers)
      {"success" => (result.code == 201), "result" => {'code' => result.code, 'msg' => result.body, 'headers' => result.headers.inspect}}
    rescue RestClient::Exception => e
      {"success" => false, "result" => {'msg' => e.to_s + e.response}}
    rescue Exception => e
      {"success" => false, "result" => {'msg' => e.message, 'trace' => e.backtrace.inspect}}
    end
  end
end