require "rails_helper"

feature "user manages letters" do
  let(:user) { Fabricate(:user) }
  context "user is logged in" do
    scenario "user writes a letter" do
      login(user)

      visit new_letter_path

      fill_in "letter[title]", with: "Dear John"
      fill_in "letter[content]", with: "Goodbye forever."
      click_on "Yours Truly, #{user.name}"

      expect(current_path).to eq(letter_path(user.letters.last))
      expect(page).to have_content("Dear John")
      expect(page).to have_content("Goodbye forever.")
    end
  end

  context "user is not logged in" do
    scenario "user tries to write a letter" do
      visit new_letter_path

      expect(current_path).to eq(root_path)
      expect(find(".flash")).to have_content("You must be signed in to view that page")
    end
  end

  scenario "user populates letter with template", js: true do
    category = Category.create(name: "Undying Love")
    template = Template.create(title: "Luv", content: "Can you feel the love?", category: category)
    login(user)

    visit new_letter_path

    select("Undying Love", :from => "Category")
    
    click_on "Yours Truly, #{user.name}"

    expect(current_path).to eq(letter_path(user.letters.last))
    expect(page).to have_content(template.title)
    expect(page).to have_content(template.content)
  end

end
