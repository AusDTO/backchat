require 'rails_helper'

RSpec.describe SubmissionsController, type: :controller do
  before :each do
    sign_in :user, create(:admin_user)
    @submission = create(:submission)
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, id: @submission.id
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #submit" do
    it "returns http success" do
      get :submit,  id: @submission.form.id, :format => :json
      expect(response).to have_http_status(:success)
    end
  end

end
