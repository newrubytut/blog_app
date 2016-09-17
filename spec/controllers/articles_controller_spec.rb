require 'rails_helper'
require 'support/macros'


RSpec.describe ArticlesController, type: :controller do

	before do
		@juan = User.create(email: "juan@example.com", password: "password")
	end

	context "owner is allowed to edit his articles" do
		it "renders the edit template" do
			login_user @juan
			article = Article.create(title: "first article", body: "body of first article", user: @juan)

			get :edit, id: article
			expect(response).to render_template :edit
		end
	end

	context "non-owner is not allowed to edit other users articles" do
		it "redirects to the root path" do

			@fred = User.create(email: "fred@example.com", password: "password")
	
			login_user @fred
			article = Article.create(title: "first article", body: "body of first article", user: @juan)

			get :edit, id: article
			expect(response).to redirect_to(root_path)
			message = "You can only edit your own articles"
			expect(flash[:danger]).to eq message
		end
	end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

end
