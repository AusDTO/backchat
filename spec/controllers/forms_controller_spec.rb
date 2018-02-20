require 'rails_helper'

RSpec.describe FormsController, type: :controller do
  before :each do
    sign_in :user, create(:admin_user)
    @form = create(:form)
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit, params: { id: @form.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, params: { id: @form.id }
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
