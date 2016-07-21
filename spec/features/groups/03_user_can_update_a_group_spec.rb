require "rails_helper"

feature "user updates a group", %(
  As an authenticated user
  I want to be able to update a group
  So it can better suit my needs
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

      expect(page).to have_button("Update")
    end

    scenario "clicking update on a group should render an update form" do
      login_as(user)
      visit root_path
      click_link("Manage Groups")
      click_link("Add New Group")
      fill_in 'Name', with: 'Revolutionary War Expenses'
      fill_in 'Description', with: 'Splitting bills with France'
      click_button("Create Group")
      click_button("Revolutionary War Expenses")
      click_button("Update")

      expect(page).to have_content("Update Group Form")
    end

    scenario "submitting update form renders updates to group" do
      login_as(user)
      visit root_path
      click_link("Manage Groups")
      click_link("Add New Group")
      fill_in 'Name', with: 'Revolutionary War Expenses'
      fill_in 'Description', with: 'Splitting bills with France'
      click_button("Create Group")
      click_button("Revolutionary War Expenses")
      click_button("Update")
      fill_in 'Name', with: 'Weekend at Mt. Vernon with the Fellas'
      fill_in 'Description', with: 'Split bills with Thomas and Ben'
      click_button("Update Group")

      expect(page).to have_content("Weekend at Mt. Vernon")
      expect(page).to have_content("Split bills with Thomas and Ben")
    end

    scenario "submitting update form with invalid information will not update
      group" do
      login_as(user)
      visit root_path
      click_link("Manage Groups")
      click_link("Add New Group")
      fill_in 'Name', with: 'Revolutionary War Expenses'
      fill_in 'Description', with: 'Splitting bills with France'
      click_button("Create Group")
      click_button("Revolutionary War Expenses")
      click_button("Update")
      fill_in 'Name', with: ''

      click_button("Update Group")
      expect(page).to have_content("Update Group Form")
    end
  end

  context "As an unauthenticated user" do
    scenario "I should not be able to update a group" do
      visit root_path

      expect(page).to_not have_link("Manage Groups")
    end
  end
end
