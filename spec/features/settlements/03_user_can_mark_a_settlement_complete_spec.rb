require "rails_helper"

feature 'user can close a settlement', %(
  As an authenticated user
  I want to be able to close a settlement
  So I can untrack settlements that have been paid
) do
  context "as an authenticated user" do
    let(:user) { FactoryGirl.create(:user) }

    scenario "I can see a button to Close Settlement on the settlement show
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
      click_button("Settle Up")

      expect(page).to have_button("Close Settlement")
    end

    scenario "clicking the Close Settlement marks the settlement as complete
      and removes it from the index" do
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
      click_button("Add Bill")
      fill_in 'Title', with: 'Horses'
      fill_in 'Amount', with: '20.02'
      click_button("Create Bill")
      click_button("Settle Up")
      click_button("Close Settlement")

      expect(page).to have_content("Open Settlements")
      expect(page).to have_link("Back To Revolutionary War Expenses")
    end
  end

  context "as an unauthenticated user" do
    scenario "I cannot close a settlement because I cannot create a group" do
      visit root_path

      expect(page).to_not have_link("Manage Groups")
    end
  end
end
