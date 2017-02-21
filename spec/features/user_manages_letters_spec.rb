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

  scenario "user shares letter with another user" do
    login(user)
    user_2 = Fabricate(:user)
    letter = Fabricate(:letter, owner_id: user.id)

    visit letter_path(letter)
    fill_in "Share This Letter", with: user_2.email

    click_on "Share"

    expect(user_2.letters_shared_with_me).to include(letter)
    expect(find(".flash")).to have_content("You shared #{letter.title} with #{user_2.email}")
  end

  scenario "user shares letter with an unregistered email" do
    login(user)
    letter = Fabricate(:letter, owner_id: user.id)

    visit letter_path(letter)
    fill_in "Share This Letter", with: "test@example.com"

    click_on "Share"

    expect(find(".flash")).to have_content("This user doesn't exist.")
  end

  scenario "user can see all their letters" do
    login(user)
    user_2 = Fabricate(:user)
    letter = Fabricate(:letter, title: "Pew Pew", owner_id: user_2.id)
    letter_2 = Fabricate(:letter, owner: user)
    Fabricate(:shared_letter, letter: letter, user: user)

    visit root_path

    expect(page).to have_content(letter.title)
    expect(page).to have_content(letter_2.title)

  end

  scenario "user can view individual letters" do
    login(user)
    user_2 = Fabricate(:user)
    letter = Fabricate(:letter, title: "Pew Pew", owner_id: user_2.id)
    Fabricate(:shared_letter, letter: letter, user: user)

    visit root_path
    click_link letter.title

    expect(current_path).to eq(letter_path(letter))
    expect(page).to have_content(letter.title)
    expect(page).to have_content(letter.content)
  end

end
