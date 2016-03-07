class OutputJobsController < ApplicationController
  load_and_authorize_resource
  # method descriptions https://gist.github.com/TonyMilton/c1b3f10c6e87da7c63bf
  def show
  end
  def run
    @result = @output_job.run()
    print @result
  end
  def queue
    SubmitOutputJob.enqueue @output_job.id
  end
end
