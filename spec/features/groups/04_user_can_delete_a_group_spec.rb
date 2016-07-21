require 'rails_helper'

feature "user deletes a group", %(
  As an authenticated user
  I want to be able to delete a group
  So I no longer have it in my group index
) do
  context "As an authenticated user" do
    let(:user) { FactoryGirl.create(:user) }

    scenario "I want to be able to navigate to a group" do
      login_as(user)
      visit root_path
      click_link("Manage Groups")
      click_link("Add New Group")
      fill_in 'Name', with: 'Revolutionary War Expenses'
      fill_in 'Description', with: 'Splitting bills with France'
      click_button("Create Group")
      click_button("Revolutionary War Expenses")

      expect(page).to have_button("Delete")
    end

    scenario "I want to be able to delete a group" do
      login_as(user)
      visit root_path
      click_link("Manage Groups")
      click_link("Add New Group")
      fill_in 'Name', with: 'Revolutionary War Expenses'
      fill_in 'Description', with: 'Splitting bills with France'
      click_button("Create Group")
      click_button("Revolutionary War Expenses")
      click_button("Delete")

      expect(page).to have_link("Add New Group")
      expect(page).to_not have_button("Revolutionary War Expenses")
    end
  end

  context "As an unauthenticated user" do
    scenario "I cannot delete a group because I cannot save a group" do
      visit root_path

      expect(page).to_not have_link("Manage Groups")
    end
  end
end
