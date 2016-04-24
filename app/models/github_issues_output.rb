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
class GithubIssuesOutput < Output
  def run (submission)
    begin
      url = 'https://api.github.com/repos/'+self.configuration["repo_name"]+'/issues'
      payload = self.configuration['issue']
      payload['body'] = submission.as_string
      payload = payload.deep_compact
      headers = {"Content-Type" => 'application/json', "Accept" => 'application/json',
                 "Authorization" => 'token ' + self.configuration["personal_access_key"]}

      result = RestClient.post(url, payload.compact.to_json, headers)
      {"success" => (result.code == 201), "result" => {'code' => result.code, 'msg' => result.body, 'headers' => result.headers.inspect}}
    rescue RestClient::Exception => e
      {"success" => false, "result" => {'msg' => e.to_s + e.response}}
    rescue Exception => e
      {"success" => false, "result" => {'msg' => e.message, 'trace' => e.backtrace.inspect}}
    end
  end
end