class OutputJobsController < ApplicationController
  load_and_authorize_resource
  # method descriptions https://gist.github.com/TonyMilton/c1b3f10c6e87da7c63bf
  def show
    @output_job = OutputJob.find(params[:id])
  end
  def run
    @output_job = OutputJob.find(params[:id])
    @result = @output_job.run()
    print @result
  end
  def queue
    @output_job = OutputJob.find(params[:id])
    @result = SubmitOutputJob.enqueue(@output_job.id)
    print @result
  end
end
