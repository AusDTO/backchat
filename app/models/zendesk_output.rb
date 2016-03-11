require 'rest-client'
class ZendeskOutput < Output
  def run (submission)
    begin
      url = 'https://'+self.configuration["zendesk_subdomain"]+'.zendesk.com/api/v2/tickets.json'
      payload = {"ticket" => self.configuration['ticket']}
      payload['ticket']['subject'] = self.form.website
      payload['ticket']['comment'] = {'body' => submission.as_string}
      headers = {"Content-Type" => 'application/json', "Accept" => 'application/json',
                 "Authorization" => 'Basic ' +
                     Base64.strict_encode64(self.configuration["zendesk_login"] + "/token:" + self.configuration["zendesk_token"])}

      result = RestClient.post(url, payload.to_json, headers)
      {"success" => (result.code == 201), "result" => {'code' => result.code, 'msg' => result.body, 'headers' => result.headers.inspect}}
    rescue RestClient::Exception => e
      {"success" => false, "result" => {'msg' => e.to_s + e.response}}
    rescue Exception => e
      {"success" => false, "result" => {'msg' => e.message, 'trace' => e.backtrace.inspect}}
    end
  end
end