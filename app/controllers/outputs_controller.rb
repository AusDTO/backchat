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
    # code to create a new output based on the parameters that
    # were submitted (and are now available in the
    # params hash)
    oparams = output_params("")
    @output = output.new(oparams)
    @output.user_id = current_user.id
    @output.save
    redirect_to @output, notice: 'Your output was successfully created.'
  end
  def update
    # code to figure out which output we're trying to update, then
    # actually update the attributes of that post.  Once that's
    # done, redirect us to somewhere like the Show page for that
    # output

    #TODO make sure current_user = output.user and don't let it change unless admin
    output = Output.find(params[:id])
    oparams = output_params(output.type)
    output.update_attributes!(oparams)
    redirect_to output_path(output), notice: 'Your output was successfully updated.'
  end

  private
  def output_params(type)
    params.permit(:name)
  end
  def destroy
    # very simple code to find the post we're referring to and
    # destroy it.  Once that's done, redirect us to somewhere fun.
  end

  def show
    @output = Output.find(params[:id])
  end

  def index
    if @user
      @outputs = Output.where(:owner => @user)
    else
      redirect_to new_user_session_path, alert: 'Please sign in to view'
    end
  end
end
