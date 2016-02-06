class FormController < ApplicationController
  load_and_authorize_resource
  def edit
  end

  def show
    @form = Form.find(params[:id])
    respond_to do |format|
      format.js { render_json @form.to_json }
    end
  end

  def new
  end
end
