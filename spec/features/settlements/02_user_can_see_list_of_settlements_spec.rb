require "rails_helper"

feature 'user sees past settlements', %(
  As an authenticated user
  I want to be able to view past settlements
  So I can keep a record of all settlements
) do
  context "as an authenticated user" do
    let(:user) { FactoryGirl.create(:user) }
    scenario "user can see a button to settlement history" do
      login_as(user)
      visit root_path
      click_link("Manage Groups")
      click_link("Add New Group")
      fill_in 'Name', with: 'Revolutionary War Expenses'
      fill_in 'Description', with: 'Splitting bills with France'
      fill_in 'Size', with: 2
      click_button("Create Group")
      click_button("Revolutionary War Expenses")
      click_button("Add Bill")
      fill_in 'Title', with: 'Cannons'
      fill_in 'Description', with: 'Need them over in Lexington'
      fill_in 'Amount', with: '50.02'
      click_button("Create Bill")

      expect(page).to have_button("Settlement History")
    end

    scenario "user can view their settlement history" do
      login_as(user)
      visit root_path
      click_link("Manage Groups")
      click_link("Add New Group")
      fill_in 'Name', with: 'Revolutionary War Expenses'
      fill_in 'Description', with: 'Splitting bills with France'
      fill_in 'Size', with: 2
      click_button("Create Group")
      click_button("Revolutionary War Expenses")
      click_button("Add Bill")
      fill_in 'Title', with: 'Cannons'
      fill_in 'Description', with: 'Need them over in Lexington'
      fill_in 'Amount', with: '50.02'
      click_button("Create Bill")
      click_button("Settlement History")

      expect(page).to have_content("Settlement History")
      expect(page).to have_content("Open Settlements")
      expect(page).to have_link("Back To Revolutionary War Expenses")
    end

    scenario "I can visit my group's page from my group's settlement index
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
      click_button("Add Bill")
      fill_in 'Title', with: 'Cannons'
      fill_in 'Description', with: 'Need them over in Lexington'
      fill_in 'Amount', with: '50.02'
      click_button("Create Bill")
      click_button("Settlement History")
      click_link("Back To Revolutionary War Expenses")

      expect(page).to have_button("Add Bill")
      expect(page).to have_button("Delete Group")
    end
  end

  context "as an unauthenticated user" do
    scenario "I should not be able to see past settlements because I cannot
      create a group which creates a settlement" do
      visit root_path

      expect(page).to_not have_link("Manage Groups")
    end
  end
end
