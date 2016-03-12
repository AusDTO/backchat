class OutputJobsController < ApplicationController
  load_and_authorize_resource
  # method descriptions https://gist.github.com/TonyMilton/c1b3f10c6e87da7c63bf
  def show
  end
  def run
    @result = @output_job.run()
    @output_job.success = @result['success']
    @output_job.result = @result['result']
    @output_job.save()
    prometheus = Prometheus::Client.registry
    output_jobs_run = prometheus.counter(:output_jobs_run, 'A counter of feedback submissions received')
    output_jobs_run.increment(output: @output.id, output_type: @output.type, success: @output_job.success)
  end
  def queue
    @result = SubmitOutputJob.enqueue @output_job.id
  end
end
