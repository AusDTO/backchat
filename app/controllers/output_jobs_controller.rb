class OutputJobsController < ApplicationController
  load_and_authorize_resource
  # method descriptions https://gist.github.com/TonyMilton/c1b3f10c6e87da7c63bf
  def edit
    @output_job = OutputJob.find(params[:id])
  end
  def new
    @output_job = OutputJob.new()
  end

  def create
    # code to create a new form based on the parameters that
    # were submitted (and are now available in the
    # params hash)
  end
  def update
    # code to figure out which form we're trying to update, then
    # actually update the attributes of that post.  Once that's
    # done, redirect us to somewhere like the Show page for that
    # form
  end
  def destroy
    # very simple code to find the post we're referring to and
    # destroy it.  Once that's done, redirect us to somewhere fun.
  end
end
