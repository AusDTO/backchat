class OutputsController < ApplicationController
  load_and_authorize_resource
  # method descriptions https://gist.github.com/TonyMilton/c1b3f10c6e87da7c63bf
  def edit
    @output = Output.find(params[:id])
  end
  def new
    @output = Output.new()
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

  def show
    @output = Output.find(params[:id])
    @output_jobs = OutputJob.where(:output_id => @output.id)
  end

  def index
    if @user
      @outputs = Output.all
    else
      redirect_to new_user_session_path, alert: 'Please sign in to view'
    end
  end
end
