require 'rails_helper'

feature 'user views bill history', %(
  As an authenticated
  I want to view my bill history
  So that I can see any outstanding debts
) do
  context "as an authenticated user" do
    let(:user) { FactoryGirl.create(:user) }

    scenario "there is a link to view the bill history on the root path" do
      login_as(user)
      visit root_path

      expect(page).to have_link("Bill History")
    end

    scenario "I can view a list of previously split bills from the root path" do
      login_as(user)
      visit root_path
      click_link("Bill History")

      expect(page).to have_content("Bill History")
    end

    scenario "I can view a list of previously split bills after adding a new
      bill" do
      login_as(user)
      visit root_path
      fill_in 'Title', with: 'Dinner'
      fill_in 'Description', with: 'Beehive Saturday Night'
      fill_in 'Amount', with: '84.38'
      fill_in 'Party Size', with: '2'
      click_button 'Create Bill'
      first(:link, 'Bill History').click

      expect(page).to have_content("Bill History")
      expect(page).to have_content("Beehive Saturday Night")
    end
  end

  context "as an unauthenticated user" do
    scenario "I cannot view a list of previosuly split bills" do
      visit root_path

      expect(page).to_not have_content("Bill History")
    end
  end
end
