require 'rails_helper'

RSpec.feature "Signin out signed-in users" do
	before do
		@juan = User.create!(email: "juan@example.com", password: "password")

		visit '/'

		click_link "Sign in"
		fill_in "Email", with: @juan.email
		fill_in "Password", with: @juan.password
		click_button "Log in"
	end

	scenario do
		visit '/'
		click_link "Sign out"
		expect(page).to have_content("Signed out successfully.")
	end

end