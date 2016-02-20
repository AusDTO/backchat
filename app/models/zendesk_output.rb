require 'rest-client'
class ZendeskOutput < Output
  def run (submission)
    begin
      url = 'https://dto.zendesk.com/api/v2/tickets.json'
      payload = configuration['ticket']
      payload['subject'] = self.form.website
      payload['comment']['body'] = submission.content.to_json
      result = RestClient.post('https://dto.zendesk.com/api/v2/tickets.json',
      payload.to_json, {contentType => 'application/json',
      :Authorization =>  'Basic ' + configuration["zendesk_login"] + "/token:" + configuration["zendesk_token"]})

      {"success" => true, "result" => {'msg' => result.to_s}.to_json}
    rescue Exception => e
      {"success" => false, "result" => {'msg' => e.message, 'trace' => e.backtrace.inspect}.to_json}
    end
  end
end