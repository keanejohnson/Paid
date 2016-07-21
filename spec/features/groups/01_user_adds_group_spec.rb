require "rails_helper"

feature 'user adds a group', %(
  As an authenticated user
  I want to be able to add a group
  So I can have people to split bills with
) do

  context "as an authenticated user" do
    let(:user) { FactoryGirl.create(:user) }

    scenario "I should see a link to manage groups upon login" do
      login_as(user)
      visit root_path

      expect(page).to have_link("Manage Groups")
    end

    scenario "I should be taken to a groups index upon clicking manage
      groups" do
      login_as(user)
      visit root_path
      click_link("Manage Groups")

      expect(page).to have_button("Add New Group")
    end

    scenario "I should be taken to a new group form to add a new group" do
      login_as(user)
      visit root_path
      click_link("Manage Groups")
      click_button("Add New Group")

      expect(page).to have_content("New Group Form")
      expect(page).to have_css("form#new_group")
    end

    scenario "I should be able to create a new group if I enter valid
      information" do
      login_as(user)
      visit root_path
      click_link("Manage Groups")
      click_button("Add New Group")
      fill_in 'Name', with: 'Revolutionary War Expenses'
      fill_in 'Description', with: 'Splitting bills with France'
      click_button("Create Group")

      expect(page).to have_button("Revolutionary War Expenses")
      expect(page).to have_button("Add New Group")
    end

    scenario "I should not be able to create a new group if I enter invalid
      information" do
      login_as(user)
      visit root_path
      click_link("Manage Groups")
      click_button("Add New Group")
      click_button("Create Group")

      expect(page).to have_content("New Group Form")
      expect(page).to_not have_button("Add New Group")
    end
  end

  context "as an unauthenticated user" do
    scenario "I should not be able to create a new group" do
      visit root_path

      expect(page).to_not have_link("Manage Groups")
    end
  end
end
