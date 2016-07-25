require "rails_helper"

feature 'user navigates to a group', %(
  As an authenticated user
  I want to be able to navigate to a group
  So I can view bill history information
) do
  context "as an authenticated user" do
    let(:user) { FactoryGirl.create(:user) }
    let(:user_2) { FactoryGirl.create(:user) }
    scenario "I can view a group I created by clicking Manage Groups" do
      login_as(user)
      visit root_path
      click_link("Manage Groups")
      click_link("Add New Group")
      fill_in 'Name', with: 'Revolutionary War Expenses'
      fill_in 'Description', with: 'Splitting bills with France'
      fill_in 'Size', with: 2
      click_button("Create Group")
      click_link("Manage Groups")

      expect(page).to have_button("Revolutionary War Expenses")
    end

    scenario "I can view a group's details by clicking on its button" do
      login_as(user)
      visit root_path
      click_link("Manage Groups")
      click_link("Add New Group")
      fill_in 'Name', with: 'Revolutionary War Expenses'
      fill_in 'Description', with: 'Splitting bills with France'
      fill_in 'Size', with: 2
      click_button("Create Group")
      click_link("Manage Groups")
      click_button("Revolutionary War Expenses")

      expect(page).to have_content("Splitting bills with France")
      expect(page).to have_content("Total Owed Per Person:")
    end

    scenario "I cannot view a group that I did not create" do
      login_as(user)
      visit root_path
      click_link("Manage Groups")
      click_link("Add New Group")
      fill_in 'Name', with: 'Revolutionary War Expenses'
      fill_in 'Description', with: 'Splitting bills with France'
      fill_in 'Size', with: 2
      click_button("Create Group")
      click_link("Sign Out")
      click_link("Sign Up")
      fill_in 'First Name', with: 'Thomas'
      fill_in 'Last Name', with: 'Jefferson'
      fill_in 'Email', with: 'original_tj@gmail.com'
      fill_in 'user_password', with: 'password'
      fill_in 'Password Confirmation', with: 'password'
      click_button 'Sign Up'
      click_link 'Manage Groups'

      expect(page).to_not have_button("Revolutionary War Expenses")
      expect(page).to have_link("Add New Group")
    end
  end

  context "as an unauthenticated user" do
    scenario "I can not view any group details" do
      visit root_path

      expect(page).to_not have_content("Manage Groups")
    end
  end
end
