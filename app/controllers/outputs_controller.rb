class OutputsController < ApplicationController
  load_and_authorize_resource
  # method descriptions https://gist.github.com/TonyMilton/c1b3f10c6e87da7c63bf
  def edit

  end
  def new

  end

  def create
    # code to create a new output based on the parameters that
    # were submitted (and are now available in the
    # params hash)
    @output = Output.new(params.require(:output).permit(:name,:type))
    @output.owner_id = current_user.id
    @output.save
    redirect_to outputs_path(@output), notice: 'Your output was successfully created.'
  end
  def update
    # code to figure out which output we're trying to update, then
    # actually update the attributes of that post.  Once that's
    # done, redirect us to somewhere like the Show page for that
    # output

    @output.update_attributes!(output_params)
    redirect_to outputs_path(@output), notice: 'Your output was successfully updated.'
  end

  private
  def output_params()
    params.require(:output).permit(:name,:configuration)
  end
  def destroy
    # very simple code to find the post we're referring to and
    # destroy it.  Once that's done, redirect us to somewhere fun.
  end

  def show

  end

  def index
    if @user
      @outputs = Output.where(:owner => @user)
    else
      redirect_to new_user_session_path, alert: 'Please sign in to view'
    end
  end
end
