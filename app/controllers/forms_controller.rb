class FormsController < ApplicationController
  load_and_authorize_resource

  # method descriptions https://gist.github.com/TonyMilton/c1b3f10c6e87da7c63bf
  def edit
    @available_outputs = Output.all
  end

  def new
    # https://github.com/plataformatec/devise/blob/master/lib/devise/controllers/helpers.rb#L101
    @form = Form.new()
  end

  def create
    # code to create a new form based on the parameters that
    # were submitted (and are now available in the
    # params hash)

    @form = Form.new(form_params)
    @form.owner_id = current_user.id
    if @form.input_fields.is_a?(::String)
      @form.input_fields = JSON.parse(@form.input_fields)
    end
    if @form.save
      redirect_to @form, notice: 'Your form was successfully created.'
    else
      render 'new'
    end

  end

  def update
    # code to figure out which form we're trying to update, then
    # actually update the attributes of that post.  Once that's
    # done, redirect us to somewhere like the Show page for that
    # form

    @form.update_attributes!(form_params)
    if @form.input_fields.is_a?(::String)
      @form.input_fields = JSON.parse(@form.input_fields)
      @form.save
    end
    redirect_to @form, notice: 'Your form was successfully updated.'
  end

  private
  def form_params
    params.require(:form).permit(:name, :website, :input_fields, :redirect_url, :output_ids => [])
  end

  def destroy
    # very simple code to find the post we're referring to and
    # destroy it.  Once that's done, redirect us to somewhere fun.
  end

  def show
    @form = Form.find(params[:id])
  end

  def index
    if @user
      @forms = Form.where(:owner => @user)
    else
      redirect_to new_user_session_path, alert: 'Please sign in to view'
    end
  end
end
