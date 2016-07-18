require 'rails_helper'

feature 'user signs in', %(
  As an unauthenticated user
  I want to sign in
  So that I can use the application
) do

  # Acceptance Criteria
  # [ ] There is an option to sign in on the page if I'm not already
  #     authenticated
  # [ ] My password is not displayed as I enter it
  # [ ] I must specify a valid email address
  # [ ] If I've entered valid credentials, I receive an onscreen message that
  #     I'm logged in and I can use the system
  # [ ] If I didn't enter valid credentials, I receive an error message and
  #     I am left unauthenticated
  # [ ] If I'm already authenticated, I don't have the option to sign in

  context "As an unauthenticated user" do
    let(:user) { FactoryGirl.create(:user) }

    scenario "I will successfully sign in with valid credentials" do
      visit root_path
      click_link "Sign In"
      fill_in("Email", with: user.email)
      fill_in("Password", with: user.password)
      click_button "Sign In"

      expect(page).to have_content("Signed in successfully")
    end

    scenario "I will not be able to sign in if I enter the wrong email" do
      visit root_path
      click_link "Sign In"
      fill_in("Email", with: "benedict.arnold@britain.com")
      fill_in("Password", with: user.password)
      click_button "Sign In"

      expect(page).to have_content("Invalid Email or Password")
    end

    scenario "I will not be able to sign in if I enter the wrong password" do
      visit root_path
      click_link "Sign In"
      fill_in("Email", with: user.email)
      fill_in("Password", with: "longlivethequeen")
      click_button "Sign In"

      expect(page).to have_content("Invalid Email or Password")
    end
  end
end
