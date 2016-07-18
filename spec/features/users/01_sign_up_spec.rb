require "rails_helper"

feature "user signs up", %{
As a prospective user
I want to create an account
So that I can use the application
} do

# Acceptance Criteria:
# * There is an option to sign up on the page if I have not already signed up
# * Clicking the link to sign up will take me to a sign up form
# * I must specify a unique and valid name, email address, and profile picture
# * If I've entered valid information, I receive an onscreen message
#   congratulating me for signing up and I can use the system
# * If I didn't enter valid information, I receive an error message and I am
#   left unauthenticated

  context "as a prospective user" do
    scenario "I can visit the root path and click a link to create a new
      account" do
        visit root_path
        click_link "Sign Up"

        expect(page).to have_css("form#new_user")
    end

    scenario "I am taken to the new user form after I click the link to create
      a new account" do
        visit root_path
        click_link "Sign Up"

        expect(page).to have_css("input#user_first_name")
        expect(page).to have_css("input#user_last_name")
        expect(page).to have_css("input#user_email")
        expect(page).to have_css("input#user_password")
        expect(page).to have_css("input#user_password_confirmation")
    end

    scenario "specifying valid and required information allows me to
      successfully create an account" do
        visit root_path
        click_link "Sign Up"
        fill_in "First Name", with: "John"
        fill_in "Last Name", with: "Smith"
        fill_in "Email", with: "john.smith@example.com"
        fill_in "user_password", with: "password"
        fill_in "Password Confirmation", with: "password"
        click_button "Sign Up"

        expect(page).to have_content("You have successfully signed up!")
        expect(page).to have_content("Sign Out")
    end

    scenario "specifying an invalid email address to create an account will
      re-render the page with an error message" do
      visit root_path
      click_link "Sign Up"
      click_button "Sign Up"

      expect(page).to have_content("can't be blank")
      expect(page).to_not have_content("Sign Out")
    end

    scenario "specifying a password confirmation that does not match password
      will re-render the page with an error message" do
      visit root_path
      click_link "Sign Up"

      fill_in "user_password", with: "password"
      fill_in "Password Confirmation", with: "somethingdifferent"
      click_button "Sign Up"

      expect(page).to have_content("doesn't match")
      expect(page).to_not have_content("Sign Out")
    end
  end
end
