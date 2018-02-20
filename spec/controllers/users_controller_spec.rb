require 'rails_helper'

RSpec.describe UsersController, :type => :controller do
	before :each do
		@user = create(:user, name: "Test", confirmed_at: Date.today)
		sign_in  @user, scope: :user
		request.env["HTTP_REFERER"] = "where_i_came_from"
	end

	it "is redirected to sign_in without a user" do
		sign_out :user
		expect(get :index).to redirect_to(new_user_session_path)
	end


	describe "PATCH #update" do

		context "with valid attributes" do

			it "changes current_user's attributes" do
				patch :update, params: { id: @user , user: build(:user, name: "test2").attributes }
				@user.reload
				expect(@user.name).to eq("test2")
			end

			it "redirects to root" do
				patch :update, params: { id: @user , user: build(:user).attributes }
				expect(response).to redirect_to root_path
			end
		end

	end
end