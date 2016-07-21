require "rails_helper"

feature "user deletes a bill", %(
  As an authenticated user
  I want to be able to delete a bill
  So I can remove it from my Bill History
) do

  context "as an authenticated user" do
    let(:user) { FactoryGirl.create(:user) }

    scenario "there should be a delete button next to a given bill" do
      login_as(user)
      visit root_path
      fill_in 'Title', with: 'Dinner'
      fill_in 'Description', with: 'Beehive Saturday Night'
      fill_in 'Amount', with: '84.38'
      fill_in 'Party Size', with: '2'
      click_button 'Create Bill'
      first(:link, 'Bill History').click

      expect(page).to have_button("Delete")
    end

    scenario "I want to be able to delete a bill" do
      login_as(user)
      visit root_path
      fill_in 'Title', with: 'Dinner'
      fill_in 'Description', with: 'Beehive Saturday Night'
      fill_in 'Amount', with: '84.38'
      fill_in 'Party Size', with: '2'
      click_button 'Create Bill'
      first(:link, 'Bill History').click
      click_button 'Delete'

      expect(page).to have_content("Bill History")
      expect(page).to_not have_content("Dinner")
    end

  end

  context "as an unauthenticated user" do
    scenario "I cannot delete a bill because I cannot save a bill" do
      visit root_path
      fill_in 'Title', with: 'Dinner'
      fill_in 'Description', with: 'Beehive Saturday Night'
      fill_in 'Amount', with: '84.38'
      fill_in 'Party Size', with: '2'
      click_button 'Create Bill'

      expect(page).to_not have_link("Bill History")
    end
  end

end
