class SubmitOutputJob < Que::Job

  def run(output_job_id)
    output_job = OutputJob.find(output_job_id)

    ActiveRecord::Base.transaction do
      # if not already finished
      if not output_job.success
        result = {"success" => false, "result" => {'msg' => "did not run"}.to_json}
        begin
          result = output_job.run()
        rescue Exception => e
          result = {"success" => false, "result" => {'msg' => e.message, 'trace' => e.backtrace.inspect}.to_json}
        end

        output_job.update_attributes :success => result["success"], :result => result['result']
        # It's best to destroy the job in the same transaction as any other
        # changes you make. Que will destroy the job for you after the run
        # method if you don't do it yourself, but if your job writes to the
        # DB but doesn't destroy the job in the same transaction, it's
        # possible that the job could be repeated in the event of a crash.
        destroy
      end
    end
  end
end
