require 'rest-client'
class Hash
  def deep_compact(options = {})
    inject({}) do |new_hash, (k,v)|
      result = v.blank?
      if v.is_a?(Array)
        result = v.first.blank?
      end
      if !result
        new_value = v.is_a?(Hash) ? v.deep_compact(options).presence : v
        new_hash[k] = new_value if new_value
      end
      new_hash
    end
  end
end
class TrelloOutput < Output
  def run (submission)
    begin
      url = 'https://api.trello.com/1/cards/'
      payload = self.configuration['card']
      payload['key'] = self.configuration['api_key']
      payload['token']= self.configuration['token']
      payload['desc'] = submission.as_string
      headers = {"Accept" => 'application/json'}
      result = RestClient.post(url, payload, headers)
      {"success" => (result.code == 201), "result" => {'code' => result.code, 'msg' => result.body, 'headers' => result.headers.inspect}}
    rescue RestClient::Exception => e
      {"success" => false, "result" => {'msg' => e.to_s + e.response}}
    rescue Exception => e
      {"success" => false, "result" => {'msg' => e.message, 'trace' => e.backtrace.inspect}}
    end
  end
end