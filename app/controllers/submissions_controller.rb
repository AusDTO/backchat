class SubmissionsController < ApplicationController
  load_and_authorize_resource

  def show
    @submission = Submission.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render_json @submission.to_json }
    end
  end

  def submit
    #@form = Form.find(params[:submission]['form'])
    #@submission = Submission.new(params[:submission])
    render_json @params.to_json
  end
end
