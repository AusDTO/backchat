# https://developers.google.com/gmail/api/quickstart/ruby
require 'google/apis/gmail_v1'
require 'googleauth'
require 'mail'
require 'time'
class GmailOutput < Output
  def run (submission)
    begin
      gmail = Google::Apis::GmailV1::GmailService.new

      gmail.authorization = Identity.find_by(user_id: self.owner_id).as_user_creds
      configuration = self.configuration
      mail = Mail.new do
        from 'no-reply@null'
        to configuration['to']
        subject configuration['subject']
      end
      text_part = Mail::Part.new do
        body submission.inspect
      end

      html_part = Mail::Part.new do
        content_type 'text/html; charset=UTF-8'
        body submission.as_html
      end

      mail.text_part = text_part
      mail.html_part = html_part

      result = gmail.send_user_message('me',
                                       upload_source: StringIO.new(mail.to_s),
                                       content_type: 'message/rfc822')

      if result.id.nil?
        {"success" => false, "result" => {'msg' => result.inspect}}
      else
        {"success" => true, "result" => {'id' => result.id}}
      end

    rescue Exception => e
      {"success" => false, "result" => {'msg' => e.message, 'trace' => e.backtrace.inspect}}
    end
  end
end
