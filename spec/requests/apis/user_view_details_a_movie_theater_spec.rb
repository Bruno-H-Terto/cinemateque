require 'rails_helper'

describe 'Usuário vê detalhes de um cinema', type: :request do
  context 'GET api/v1/movie_theaters/:id' do
    it 'com sucesso' do
      movie_theater = MovieTheater.create!(name: 'Cine Santa Cruz', city: 'Juiz de Fora/MG')
      movie_theater.rooms.create(name: 'Sala 01', capacity: 100)
      movie_theater.rooms.create(name: 'Sala 02', capacity: 130)

      get "/api/v1/movie_theaters/#{movie_theater.id}"

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response['movie_theater']['name']).to eq 'Cine Santa Cruz'
      expect(json_response['movie_theater']['city']).to eq 'Juiz de Fora/MG'
      expect(json_response['max_capacity']).to eq 230
      expect(json_response.inspect).not_to include 'created_at'
      expect(json_response.inspect).not_to include 'updated_at'
    end

    it 'e não localiza um cinema cadastrado' do
      get '/api/v1/movie_theaters/999999999'

      expect(response.status).to eq 404
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response['error_message']).to eq 'Nenhum cinema localizado.'
    end

    it 'e sofre erro interno' do
      allow(MovieTheater).to receive(:find_by!).and_raise(ActiveRecord::ActiveRecordError)
      movie_theater = MovieTheater.create!(name: 'Cine Santa Cruz', city: 'Juiz de Fora/MG')
      movie_theater.rooms.create(name: 'Sala 01', capacity: 100)
      movie_theater.rooms.create(name: 'Sala 02', capacity: 130)

      get "/api/v1/movie_theaters/#{movie_theater.id}"

      expect(response.status).to eq 500
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response['error_message']).to eq 'Ocorreu um erro interno.'
    end
  end
end