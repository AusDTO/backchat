require 'rest-client'
class ZendeskOutput < Output
  def run (submission)
    begin
      url = 'https://'+configuration["zendesk_domain"]+'.zendesk.com/api/v2/tickets.json'
      payload = configuration['ticket']
      payload['subject'] = self.form.website
      payload['comment']['body'] = submission.content.to_json
      result = RestClient.post(url,
      payload.to_json, {contentType => 'application/json',
      :Authorization =>  'Basic ' + configuration["zendesk_login"] + "/token:" + configuration["zendesk_token"]})

      {"success" => (result.code == 201), "result" => {'code'=> result.code,'msg' => result.to_s}}
    rescue Exception => e
      {"success" => false, "result" => {'msg' => e.message, 'trace' => e.backtrace.inspect}}
    end
  end
end