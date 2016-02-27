class SubmissionsController < ApplicationController
  # allow external post for submit
  skip_before_action :verify_authenticity_token, if: :submit

  def show
    @submission = Submission.find(params[:id])
    authorize! :read, @submission
    respond_to do |format|
      format.html
      format.json { render_json @submission.to_json }
    end
  end

  def submit
    @form = Form.find(params[:id])
    @submission = Submission.new()
    @submission.form_id = @form.id
    @submission.path = params[:referrer]
    @submission.content = params.to_json
    @submission.save()
    respond_to do |format|
      format.json do
        render json: @submission.to_json
      end
    end
  end
end
