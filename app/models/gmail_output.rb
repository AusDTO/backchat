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

      html_part = Mail::Part.new do
        content_type 'text/html; charset=UTF-8'
        body submission.as_html
      end

      mail.html_part = html_part

      #if configuration['files_allowed'] == 'Yes'
      #  mail.attachments[submission.file_filename] = submission.file.read
      #end
      if configuration['data_attached'] == 'CSV'
        mail.attachments['data.csv'] = { :mime_type => 'text/csv',  :content => submission.as_csv }
      end
      if configuration['data_attached'] == 'JSON'
        mail.attachments['data.json'] = { :mime_type => 'application/json',  :content => submission.to_json }
      end
      result = gmail.send_user_message('me',
                                       upload_source: StringIO.new(mail.to_s),
                                       content_type: 'message/rfc822')

      if result.id.nil?
        {"success" => false, "result" => {'msg' => result.inspect}}
      else
        {"success" => true, "result" => {'id' => result.id, 'labels' => result.label_ids, 'threads' => result.thread_ids}}
      end

    rescue Exception => e
      {"success" => false, "result" => {'msg' => e.message, 'trace' => e.backtrace.inspect}}
    end
  end
end
