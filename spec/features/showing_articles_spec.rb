require 'rails_helper'

RSpec.feature "showing an article" do
	before do
		@article = Article.create(title: "The First article", body: "Body of first article")
	end

	scenario "Display individual article" do
		visit "/"

		click_link @article.title

		expect(page).to have_content(@article.title)
		expect(page).to have_content(@article.body)

		expect(current_path).to eq(article_path(@article))
	end
end