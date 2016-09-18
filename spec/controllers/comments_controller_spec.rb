require 'rails_helper'
require 'support/macros'

RSpec.describe CommentsController, type: :controller do
	describe "POST #create" do
		before do
			@juan = User.create(email: "juan@example.com", password: "password")
		end

		context "signed in user" do
			it "can create a comment" do
				login_user @juan
				article = Article.create(title: "first Article", body: "body of first article", user: @juan)

				post :create, comment: {body: "Awesome post"},
					article_id: article.id
				expect(flash[:sucess]).to eq("Comment has been created")
			end
		end
	end

	describe "non-signed in user" do
		it "is redirected to the sign in page" do
			login_user nil
			
			article = Article.create(title: "first Article", body: "body of first article", user: @juan)

			post :create, comment: {body: " Awesome post"},
				article_id: article.id

			expect(response).to redirect_to new_user_session_path
		end
	end
end
