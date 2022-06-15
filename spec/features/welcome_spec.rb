require 'rails_helper'

feature "Welcome", type: :feature do
  scenario "Show welcome message" do
    visit(root_path)
    
    expect(page).to have_content("Bem-Vindo")
  end

  scenario "Verify client registration" do
    visit(root_path)

    expect(find("ul li")).to have_link("Cadastrar Cliente")
  end
end
