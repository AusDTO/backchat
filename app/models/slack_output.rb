class SlackOutput < Output

  def run (submission)
    begin
      # https://api.slack.com/docs/attachments
      attachment = Slack::Attachment.new(
          fallback: "Feedback for " + submission.form.website + " at " + submission.created_at.to_s(:default) + "\n"+submission.content.inspect,
          text: "Feedback for " + submission.form.website + " at " + submission.created_at.to_s(:default)
      )
      for key in submission.content.keys
        attachment.add_field(key, submission.content[key])
      end
if self.configuration.nil?
  {"success" => false, "result" => { 'msg' => "configuration missing or blank"}}
  return
end
      message = Slack::Message.new('Feedback', attachment)
      poster = Slack::Poster.new(self.configuration['webhook_url'])
      result = poster.send_message(message)
      if result.status == 200 && result.body == 'ok'
        {"success" => true, "result" => {'code' => result.status, 'msg' => result.inspect}}
      else
        {"success" => false, "result" => {'code' => result.status, 'msg' => result.inspect}}
      end
    rescue Exception => e
      {"success" => false, "result" => {'msg' => e.message, 'trace' => e.backtrace.inspect}}
    end
  end
end