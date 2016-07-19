require 'rails_helper'

feature 'user signs out', %(
  As an authenticated User
  I want to be able to sign out
  So I can leave the app
) do
  # Acceptance Criteria
  # [X] There is an option to sign out on the page I am currently on
  # [] Able to log out from any page
  # [X] When signing out, a message is displayed that I have signed out
  # [X] After signing out, a link to sign is displayed

  context "as an authenticated user" do
    scenario "I am able to sign out" do
      user = FactoryGirl.create(:user)
      login_as(user)
      visit root_path
      click_link "Sign Out"

      expect(page).to have_content("Signed out successfully")
      expect(page).to have_button("Sign In")
    end
  end
end
