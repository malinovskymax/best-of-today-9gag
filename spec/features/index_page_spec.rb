require 'rails_helper'

describe 'View best of 9gag posts on main page', type: :feature, js: true do
  before do
    visit root_path
  end

  it 'should render at least header and footer' do
    expect(page).to have_content("Best of today's 9gag")
    expect(page).to have_link('Max Malinovsky')
  end

  it 'should display posts' do
    # todo Factory Girl Post.create!(link: 'http://9gag.com/gag/agNodvg', rating: 11_000)
    # visit root_path
    # expect(page).to have_content('Rating:')
  end

  it 'should redirect to main page from every other page' do
    visit '/wrong_page'
    expect(page).to have_content("Best of today's 9gag")
    expect(page).to have_link('Max Malinovsky')
  end

end