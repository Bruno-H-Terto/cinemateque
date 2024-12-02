require 'rails_helper'

describe 'Usuário adiciona atores' do
  it 'com sucesso' do
    user = FactoryBot.create(:user, email: 'joao@email.com')
    login_as user

    visit root_path
    within('nav') do
      click_on 'Atores'
    end
    click_on 'Novo Ator/Atriz'
    fill_in 'Nome', with: 'Tom Hanks'
    fill_in 'Data de nascimento', with: '09/07/1956'
    fill_in 'Nacionalidade', with: 'Americano'
    click_on 'Criar Ator'

    expect(page).to have_content 'Ator/Atriz Tom Hanks cadastrado com sucesso!'
    expect(page).to have_content 'Artista Tom Hanks'
    expect(page).to have_content '09/07/1956'
    expect(page).to have_content 'Americano'
    expect(page).to have_content 'Participações em filmes'
  end

  it 'e adiciona nova participação em filmes' do
    Movie.create!(title: 'Forrest Gump', year: 1994, director: 'Robert Zemeckis', 
              plot:  'Mesmo com o raciocínio lento, Forrest Gump ...')
    actor = Actor.create!(name: 'Tom Hanks', birth_date: '09/07/1956', nationality: 'Americana')
    user = FactoryBot.create(:user, email: 'joao@email.com')
    login_as user

    visit root_path
    within('nav') do
      click_on 'Atores'
    end
    click_on 'Tom Hanks'
    click_on 'Novo papel'
    select 'Forrest Gump', from: 'Filme'
    fill_in 'Personagem', with: 'Forrest Gump'
    click_on 'Criar Participação'

    expect(page).to have_content 'Participação adicionada com sucesso!'
    within '#actors-movies' do
      expect(page).to have_content 'Filme: Forrest Gump'
      expect(page).to have_content 'Personagem: Forrest Gump'
    end
  end
end