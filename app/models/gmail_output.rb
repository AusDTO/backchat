# https://developers.google.com/gmail/api/quickstart/ruby
require 'google/apis/gmail_v1'
require 'googleauth'
require 'mail'
require 'time'
class GmailOutput < Output
  def run (submission)
    begin
      gmail = Google::Apis::GmailV1::GmailService.new

      gmail.authorization = self.owner.identity.as_user_cred

      mail = Mail.new do
        from 'no-reply@null'
        to configuration['to']
        subject configuration['subject']
        body submission.to_json
      end

      result = gmail.send_user_message('me',
                                       upload_source: StringIO.new(mail.to_s),
                                       content_type: 'message/rfc822')

      if result.id.nil?
        {"success" => false, "result" => {'msg' => result.to_s}}
      else
        {"success" => false, "result" => {'id' => result.id}}
      end

    rescue Exception => e
      {"success" => false, "result" => {'msg' => e.message, 'trace' => e.backtrace.inspect}}
    end
  end
end
