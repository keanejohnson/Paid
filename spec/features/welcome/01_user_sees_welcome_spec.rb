require "rails_helper"

feature 'user sees welcome page', %(
  As an unauthenticated user,
  I want to be able to see a welcome page
  So I can view something as the root path
) do
  context "as an unauthenticated user" do
    scenario "I see a welcome page when navigating to the root path" do
      visit root_path

      expect(page).to have_content("PAID")
      expect(page).to have_link("Sign Up")
      expect(page).to have_link("Sign In")
    end
  end
end
