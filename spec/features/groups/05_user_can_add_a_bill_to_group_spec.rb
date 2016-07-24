require 'rails_helper'

feature "user adds a bill to a group", %(
  As an authenticated user,
  I want to be able to add a bill to a group
  So that I can split bills with friends
) do
  context "as an authenticated user" do
    let(:user) { FactoryGirl.create(:user) }

    scenario "I want to be able to navigate to a group" do
      login_as(user)
      visit root_path
      click_link("Manage Groups")
      click_link("Add New Group")
      fill_in 'Name', with: 'Revolutionary War Expenses'
      fill_in 'Description', with: 'Splitting bills with France'
      fill_in 'Size', with: '4'
      click_button("Create Group")
      click_button("Revolutionary War Expenses")

      expect(page).to have_button("Add Bill")
    end

    scenario "I want to be able to add a bill to a group" do
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

      expect(page).to have_css("form#new_bill")
    end

    scenario "I should be able to add a bill with valid information" do
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
      fill_in 'Party Size', with: 4
      click_button 'Create Bill'

      expect(page).to have_content("Revolutionary War Expenses")
      expect(page).to have_content("$25.01")
    end

    scenario "I should not be able to add a bill with invalid information" do
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
      click_button("Create Bill")

      expect(page).to have_css("form#new_bill")
      expect(page).to have_content("Something Went Wrong")
      expect(page).to_not have_content("Total Owed Per Person: ")
    end
  end

  context "as an unauthenticated user" do
    scenario "I should not be able to add a bill to a group because I cannot
      create a group" do
      visit root_path

      expect(page).to_not have_link("Manage Groups")
    end
  end
end
