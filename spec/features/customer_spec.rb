require 'rails_helper'

RSpec.feature "Customers", type: :feature do
  scenario "Link to client registration" do
    visit(root_path)

    expect(page).to have_link("Cadastrar Cliente")
  end

  scenario "Verify link to new client" do
    visit(root_path)
    click_on("Cadastrar Cliente")

    expect(page).to have_content("Lista de Clientes")
    expect(page).to have_link("Novo Cliente")
  end

  scenario "Verify new client form" do
    visit(customers_path)
    click_on("Novo Cliente")

    expect(page).to have_content("Novo Cliente")
  end

  scenario "Add new valid client" do
    visit(new_customer_path)
    customer_name = Faker::Name.name

    fill_in(:Nome, with: customer_name)
    fill_in(:Email, with: Faker::Internet.email)
    fill_in(:Telefone, with: Faker::PhoneNumber.phone_number)
    attach_file("Foto de Perfil", "#{Rails.root}/spec/fixtures/eu.jpeg")
    choose(option: [:S,:N].sample)
    click_on("Criar Cliente")

    expect(page).to have_content("Cliente cadastrado com sucesso")
    expect(Customer.last.name).to eq(customer_name)
  end

  scenario "Blank information test" do
    visit(new_customer_path)
    click_on("Criar Cliente")

    expect(page).to have_content("não pode ficar em branco")
  end

  scenario "Show client" do
    customer = create(:customer)

    visit(customer_path(customer.id))

    expect(page).to have_content(customer.name)
    expect(page).to have_content(customer.email)
    expect(page).to have_content(customer.phone)
  end

  scenario "Test Index" do
    customer1 = create(:customer)

    customer2 = create(:customer)

    visit(customers_path)

    expect(page).to have_content(customer1.name).and have_content(customer2.name)
  end

  scenario "Update Cliente" do
    customer = create(:customer)
    new_name = Faker::Name.name

    visit(edit_customer_path(customer.id))
    fill_in("Nome", with: new_name)
    click_on("Editar Cliente")

    expect(page).to have_content("Cliente atualizado com sucesso")
    expect(page).to have_content(new_name)
  end

  scenario "Verify show link" do
    customer = create(:customer)

    visit(customers_path)
    find(:xpath, "/html/body/table/tbody/tr[1]/td[2]/a").click

    expect(page).to have_content("Mostrando Cliente")
  end

  scenario "Verify edit link" do
    customer = create(:customer)

    visit(customers_path)
    find(:xpath, "/html/body/table/tbody/tr[1]/td[3]/a").click

    expect(page).to have_content("Editar Cliente")
  end

  scenario "Verify destroy link", js: true do
    customer = create(:customer)
    visit(customers_path)
    find(:xpath, "/html/body/table/tbody/tr[1]/td[4]/a").click
    1.second
    page.driver.browser.switch_to.alert.accept

    expect(page).to have_content("Cliente excluido com sucesso")
  end
end
