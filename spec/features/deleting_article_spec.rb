require 'rails_helper'

RSpec.feature "Deleting an Article" do
	
	before do
		juan = User.create(email: "juan@example.com", password: "password")
		login_as(juan)
		@article =Article.create(title: "First Article", body: "Body of first article", user: juan)
	end

	scenario "A user deltetes an article" do
		visit "/"

		click_link @article.title
		click_link "Delete Article"

		expect(page).to have_content("Article has been deleted")
		expect(current_path).to eq(articles_path)
	end
end