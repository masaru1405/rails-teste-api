require 'rails_helper'

RSpec.describe 'NetflixShow', type: :request do
  # GET
  describe 'GET /netflix_shows' do
    it 'return all datas and status code 200 OK' do
      get '/netflix_shows'
      expect(response.body).not_to be_empty
      expect(response).to have_http_status(:ok)
    end
  end

  # GET by id
  describe 'GET /netflix_shows/:id' do
    it 'return a specific data by id' do
      data = NetflixShow.create!(title: 'Seinfeld')

      get "/netflix_shows/#{data.id}"

      json_parsed = JSON.parse(response.body)

      expect(response).to have_http_status(:ok)
      expect(json_parsed['title']).to eq(data.title)
    end
  end

  describe 'GET /netflix_shows?params=x' do
    it 'filtering by country, genre and year. Return status code 200' do
      data = NetflixShow.create!(title: 'Lost', show_type: 'TV Show', release_year: '2005', country: 'United States')

      get "/netflix_shows?genre=#{data.show_type}"
      expect(response).to have_http_status(:ok)

      get "/netflix_shows?year=#{data.release_year}"
      expect(response).to have_http_status(:ok)

      get "/netflix_shows?country=#{data.country}"
      expect(response).to have_http_status(:ok)

      get "/netflix_shows?genre=#{data.show_type}&country=#{data.country}&year=#{data.release_year}"
      expect(response).to have_http_status(:ok)
    end
  end

  # POST
  describe 'POST /netflix_shows' do
    context 'when the request is valid and have duplicate data' do
      let(:new_data) do
        {
          title: 'Turma da Monica',
          show_type: 'TV Show',
          release_year: '2015',
          country: 'Brazil',
          date_added: 'March 25, 2018',
          description: 'Lorem Ipsummm.'
        }
      end

      it 'return status code 201 created and 422 unprocessable_entity' do
        post '/netflix_shows', params: new_data, as: :json
        expect(response).to have_http_status(:created)

        post '/netflix_shows', params: new_data, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  # DELETE
  describe 'DELETE /netflix_shows/:id' do
    it 'returns status code 204' do
      data = NetflixShow.create!(title: 'Teste')
      delete "/netflix_shows/#{data.id}"
      expect(response).to have_http_status(:no_content)
    end
  end
end
