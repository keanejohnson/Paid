require 'rails_helper'

feature 'user adds a bill', %(
  As an authenticated or unauthenticated user
  I want to add a bill
  So that I can figure out how much I owe
) do
  # Acceptance Criteria:
  # [X] There is an option to add a new bill on the root page
  # [X] There are form fields for title, description, amount and party size
  # [X] There is a button to submit (create bill)
  # [X] Submitting the form takes me to a new page
  # [X] New page contains information from form and amount owed per person

  context "as an unauthenticated use" do
    scenario "I want to be able to see a form for a new bill" do
      visit root_path

      expect(page).to have_css("form#new_bill")
    end

    scenario "sepcifying valid information should create a new bill" do
      visit root_path
      fill_in 'Title', with: 'Dinner'
      fill_in 'Description', with: 'Beehive Saturday Night'
      fill_in 'Amount', with: '84.38'
      fill_in 'Party Size', with: '2'
      click_button 'Create Bill'

      expect(page).to have_content('Dinner')
      expect(page).to have_content('Beehive Saturday Night')
      expect(page).to have_content('Total: $84.38')
      expect(page).to have_content('Splits: 2')
      expect(page).to have_content('Everybody Owes: $42.19')
    end

    scenario "specifying invalid information should not create a new bill" do
      visit root_path
      fill_in 'Title', with: 'Dinner'
      fill_in 'Description', with: 'Beehive Saturday Night'
      fill_in 'Amount', with: 'amount'
      fill_in 'Party Size', with: '2'
      click_button 'Create Bill'

      expect(page).to have_css("form#new_bill")
      expect(page).to have_content("Something went wrong")
      expect(page).to_not have_content("Everybody Owes:")
    end
  end
end
