require 'rails_helper'

feature 'user adds other member to group', %(
  As an authenticated user,
  I want to be able to add other members to my group
  So that I can split bills with them
) do

  context "as an authenticated user" do
    let(:user) { FactoryGirl.create(:user) }

    scenario "I should be able to see a button to add a user to a group" do
      login_as(user)
      visit root_path
      click_link("Manage Groups")
      click_link("Add New Group")
      fill_in 'Name', with: 'Revolutionary War Expenses'
      fill_in 'Description', with: 'Splitting bills with France'
      fill_in 'Size', with: 2
      click_button("Create Group")
      click_button("Revolutionary War Expenses")

      expect(page).to have_link("Add Members")
    end

    scenario "clicking on the Add Users button should take me to the Add Users
      page" do
      login_as(user)
      visit root_path
      click_link("Manage Groups")
      click_link("Add New Group")
      fill_in 'Name', with: 'Revolutionary War Expenses'
      fill_in 'Description', with: 'Splitting bills with France'
      fill_in 'Size', with: 2
      click_button("Create Group")
      click_button("Revolutionary War Expenses")
      click_link("Add Members")

      expect(page).to have_content("Add User To Group")
    end

    scenario "the Add Users To Group page should have a form to add users" do
      login_as(user)
      visit root_path
      click_link("Manage Groups")
      click_link("Add New Group")
      fill_in 'Name', with: 'Revolutionary War Expenses'
      fill_in 'Description', with: 'Splitting bills with France'
      fill_in 'Size', with: 2
      click_button("Create Group")
      click_button("Revolutionary War Expenses")
      click_link("Add Members")

      expect(page).to have_content("User")
      expect(page).to have_button("Add User")
    end

    scenario "selecting a user and clicking submit will redirect you back to
      the group show page" do
      login_as(user)
      visit root_path
      click_link("Manage Groups")
      click_link("Add New Group")
      fill_in 'Name', with: 'Revolutionary War Expenses'
      fill_in 'Description', with: 'Splitting bills with France'
      fill_in 'Size', with: 2
      click_button("Create Group")
      click_button("Revolutionary War Expenses")
      click_link("Add Members")
      select("George", from: "Users")
      click_button("Add User")

      expect(page).to have_content("Revolutionary War Expenses")
      expect(page).to have_button("Add Bill")
    end
  end

  context "as an unauthenticated user" do
    scenario "I should not be able to add members to a group because I cannot
      create a group" do
      visit root_path

      expect(page).to_not have_link("Manage Groups")
    end
  end
end
