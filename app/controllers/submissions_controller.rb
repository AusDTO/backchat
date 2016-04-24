class SubmissionsController < ApplicationController
  # allow external post for submit
  skip_before_action :verify_authenticity_token, only: [:submit]
  after_action :allow_iframe, only: :submit
  before_filter :start_counter
  def start_counter
    if not $feedback_received
      $feedback_received = Prometheus::Client.registry.counter(:feedback_received, 'A counter of feedback submissions received')
    end
  end

  def show
    @submission = Submission.find(params[:id])
    authorize! :read, @submission
    respond_to do |format|
      format.html
      format.json { render json: @submission.to_json }
    end
  end
  def submit
    @form = Form.find(params[:id])
    @submission = Submission.new()
    @submission.form_id = @form.id
    if params[:referrer]
      @submission.path = params[:referrer]
    end
    if params[:satisfaction]
      @submission.satisfaction = params[:satisfaction]
    end
    if params[:file]
      @submission.file = params[:file]
      #TODO save mime/type and/or filename https://github.com/refile/refile
      params[:file] = nil
    end
    #TODO filter by expected input fields
    @submission.content = params.to_json
    @submission.save()
    for output in @form.outputs
      @job = OutputJob.new(output_id: output.id, submission_id: @submission.id)
      @job.save()
      SubmitOutputJob.enqueue @job.id
    end
    $feedback_received.increment(form: @form.id)
    respond_to do |format|
      format.html do
        if (@form.redirect_url)
          redirect_to @form.redirect_url+"?referrer=#{@submission.path}"
        end
      end
      format.json do
        render json: @submission.to_json
      end
    end
  end
  private
  def allow_iframe
    response.headers.except! 'X-Frame-Options'
  end
end
