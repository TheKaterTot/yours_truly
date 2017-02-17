require "rails_helper"

feature "user manages letter" do
  let(:user) { Fabricate(:user) }
  context "user is logged in" do
    scenario "user writes a letter" do
      allow_any_instance_of(ApplicationController)
      .to receive(:current_user).and_return(user)

      visit new_letter_path

      fill_in "letter[title]", with: "Dear John"
      fill_in "letter[content]", with: "Goodbye forever."
      click_on "Sincerely, #{user.name}"

      expect(current_path).to eq(letter_path(user.letters.last))
      expect(page).to have_content("Dear John")
      expect(page).to have_content("Goodbye forever.")
    end
  end
end
