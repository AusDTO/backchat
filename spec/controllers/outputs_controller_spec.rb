require 'rails_helper'

RSpec.describe OutputsController, type: :controller do
  before :each do
    sign_in :user, create(:admin_user)
    @output = create(:output)
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit, id: @output.id
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, id: @output.id
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

end
