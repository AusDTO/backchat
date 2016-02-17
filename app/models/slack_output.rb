require 'slack-notifier'

class SlackOutput < Output
  def run (submission)
    begin
      attachment = Slack::Attachment.new(
          fallback: "Feedback for" + submission.form.website + " at " + submission.created_at + " - " + link_to(submission),
          text: "<"+link_to(submission)+"|Feedback> for" + submission.form.website + " at " + submission.created_at + "\n"+submission.content
      )
      # attachment.add_field('Name1', 'Value1')
      # https://api.slack.com/docs/attachments

      message = Slack::Message.new('Feedback', attachment)
      poster = Slack::Poster.new(self.configuration['webhook_url'])
      result = poster.send_message(message)
      if result == 'ok'
        {"success" => true, "result" => {'msg' => result}.to_json}
      else
        {"success" => false, "result" => {'msg' => result}.to_json}
      end
    rescue Exception => e
      {"success" => false, "result" => {'msg' => e.message, 'trace' => e.backtrace.inspect}.to_json}
    end
  end
end