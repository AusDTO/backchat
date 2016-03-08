require 'rails_helper'

RSpec.describe SubmissionsController, type: :controller do
  before :each do
    @submission = create(:submission)
  end

  describe "GET #show" do
    it "returns http success" do
      get :show
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #submit" do
    it "returns http success" do
      get :submit
      expect(response).to have_http_status(:success)
    end
  end

end
