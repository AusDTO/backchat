class SubmissionsController < ApplicationController
  # allow external post for submit
  skip_before_action :verify_authenticity_token, only: [:submit]

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
    @submission.path = params[:referrer]
    if params[:satisfaction]
      @submission.satisfaction = params[:satisfaction]
    end
    @submission.content = params.to_json
    @submission.save()
    for output in @form.outputs
      @job = OutputJob.new(output_id: output.id, submission_id: @submission.id)
      @job.save()
      SubmitOutputJob.enqueue @job.id
    end
    respond_to do |format|
      format.json do
        render json: @submission.to_json
      end
    end
  end
end
