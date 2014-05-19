require 'spec_helper'

describe "Signing up" do 
	it "allows a user to sign up for the site and create the object in the database" do
		expect(User.count).to eq(0)

		visit "/"
		expect(page).to have_content("Sign Up")
		click_link "Sign Up"

		fill_in "First Name", with: "Tom"
		fill_in "Last Name", with: "Tester"
		fill_in "Email", with: "tom@tester.com"
		fill_in "Password", with: "password"
		fill_in "Confirm Password", with: "password"
		click_button "Sign Up"

		expect(User.count).to eq(1)
	end		
end