require 'rails_helper'

RSpec.describe OutputJobsController, type: :controller do
  before :each do
    sign_in :user, create(:admin_user)
    @output_job = create(:output_job)
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, id: @output_job.id
      expect(response).to have_http_status(:success)
    end
  end


end
