module OutputJobHelper
  def output_job_path(output_job)
    '/outputs/jobs/'+output_job.id
  end
  def output_job_run_path(output_job)
    '/outputs/jobs/' + output_job.id + '/run'
  end
  def output_job_queue_path(output_job)
    '/outputs/jobs/' + output_job.id + '/queue'
    end
end
