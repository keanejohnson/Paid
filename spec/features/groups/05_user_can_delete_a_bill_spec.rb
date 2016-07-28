require 'rails_helper'

feature 'user deletes a bill from a group', %(
  As an authenticated user,
  I want to be able to delete a bill from a group
  So that I can remove it if I added it in error
) do
  context "As an authenticated user" do
    let(:user) { FactoryGirl.create(:user) }
    scenario "I should see a delete button next to a given bill I add" do
      login_as(user)
      visit root_path
      click_link("Manage Groups")
      click_link("Add New Group")
      fill_in 'Name', with: 'Revolutionary War Expenses'
      fill_in 'Description', with: 'Splitting bills with France'
      fill_in 'Size', with: '4'
      click_button("Create Group")
      click_button("Revolutionary War Expenses")
      click_button("Add Bill")
      fill_in 'Title', with: 'Dinner'
      fill_in 'Description', with: 'Beehive Saturday Night'
      fill_in 'Amount', with: '100.04'
      click_button 'Create Bill'

      expect(page).to have_button("Delete")
    end

    scenario "I should delete the bill when clicking delete" do
      login_as(user)
      visit root_path
      click_link("Manage Groups")
      click_link("Add New Group")
      fill_in 'Name', with: 'Revolutionary War Expenses'
      fill_in 'Description', with: 'Splitting bills with France'
      fill_in 'Size', with: '4'
      click_button("Create Group")
      click_button("Revolutionary War Expenses")
      click_button("Add Bill")
      fill_in 'Title', with: 'Dinner'
      fill_in 'Description', with: 'Beehive Saturday Night'
      fill_in 'Amount', with: '100.04'
      click_button 'Create Bill'
      click_button 'Delete'

      expect(page).to_not have_content("Dinner")
      expect(page).to have_button("Add Bill")
    end
  end

  context "As an unauthenticated user" do
    scenario "I should not be able to delete a bill from a group because I
      cannot create a group" do
      visit root_path

      expect(page).to_not have_link("Manage Groups")
    end
  end
end
