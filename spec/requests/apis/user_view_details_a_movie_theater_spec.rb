require 'rails_helper'

describe 'Usuário vê detalhes de um cinema', type: :request do
  context 'GET api/v1/movie_theaters/:id' do
    it 'com sucesso' do
      movie_theater = MovieTheater.create!(name: 'Cine Santa Cruz', city: 'Juiz de Fora/MG')

      get "/api/v1/movie_theaters/#{movie_theater.id}"

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response['movie_theater']['name']).to eq 'Cine Santa Cruz'
      expect(json_response['movie_theater']['city']).to eq 'Juiz de Fora/MG'
      expect(json_response.inspect).not_to include 'created_at'
      expect(json_response.inspect).not_to include 'updated_at'
    end
  end
end