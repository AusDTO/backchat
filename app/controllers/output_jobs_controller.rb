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
  end
  def queue
    @result = SubmitOutputJob.enqueue @output_job.id
  end
end
