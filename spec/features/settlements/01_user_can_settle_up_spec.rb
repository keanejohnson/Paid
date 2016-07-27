require "rails_helper"

feature 'user settles up', %(
  As an authenticated user
  I want to be able to settle up
  So I know how much I need to pay everybody
) do
  context "as an authenticated user" do
    let(:user) { FactoryGirl.create(:user) }

    scenario "I should be able to see a button to settle up on the group
      show page" do
      login_as(user)
      visit root_path
      click_link("Manage Groups")
      click_link("Add New Group")
      fill_in 'Name', with: 'Revolutionary War Expenses'
      fill_in 'Description', with: 'Splitting bills with France'
      fill_in 'Size', with: 2
      click_button("Create Group")
      click_button("Revolutionary War Expenses")

      expect(page).to have_button("Settle Up")
    end

    scenario "clicking settle up takes me to a new page" do
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

      expect(page).to have_content("Bills In This Settlement")
      expect(page).to have_content("User Is Owed")
    end

    scenario "clicking settle up tells me how much a given user has paid" do
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
      click_button("Settle Up")

      expect(page).to have_content("George")
      expect(page).to have_content("$25.01")
    end

    scenario "clicking settle up tells me how much other group members owe
      to the group member who paid" do
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

      expect(page).to have_content("$35.02")
    end
  end

  context "as an unauthenticated user" do
    scenario "I should not be able to settle up because I cannot create a
      group" do
      visit root_path

      expect(page).to_not have_link("Manage Groups")
    end
  end
end
