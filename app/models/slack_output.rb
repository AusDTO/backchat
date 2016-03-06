class SlackOutput < Output
  def link_to (submission)
    "zzz"
  end
  def run (submission)
    begin
      attachment = Slack::Attachment.new(
          fallback: "Feedback for" + submission.form.website + " at " + submission.created_at.to_s(:default) + " - " + link_to(submission),
          text: "<"+link_to(submission)+"|Feedback> for" + submission.form.website + " at " + submission.created_at.to_s(:default) + "\n"+submission.content.inspect
      )
      # attachment.add_field('Name1', 'Value1')
      # https://api.slack.com/docs/attachments

      message = Slack::Message.new('Feedback', attachment)
      poster = Slack::Poster.new(self.configuration['webhook_url'])
      result = poster.send_message(message)
      if result.status == 200 && result.body == 'ok'
        {"success" => true, "result" => {'code' =>result.status, 'msg' => result.inspect}}
      else
        {"success" => false, "result" => {'code' =>result.status, 'msg' => result.inspect}}
      end
    rescue Exception => e
      {"success" => false, "result" => {'msg' => e.message, 'trace' => e.backtrace.inspect}}
    end
  end
end