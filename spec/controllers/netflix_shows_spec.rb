require 'rails_helper'

#describe NetflixShowsController, type: :controller do
  # it 'request index and return 200 OK' do
  #   request.accept = 'application/json'
  #   get :index
  #   expect(response).to have_http_status(:ok)
  # end

  # it 'teste' do
  #   request.accept = 'application/json'
  #   get :show, params: {id: 10}
  #   expect(response).to have_http_status(:ok)
  # end

  # it 'return not found if data does not exist' do
  #   request.accept = 'application/json'
  #   data = NetflixShow.last
  #   data_id = (data.id.to_i) + 1
  #   get :show, params: {id: data_id.to_s}
  #   expect(response).to have_http_status(:not_found)
  # end

  # it 'create and return all data' do
  #   request.accept = 'application/json'
  #   data = NetflixShow.create!(
  #     title: 'Turma da Monica',
  #     show_type: 'TV Show',
  #     release_year: '2016',
  #     country: 'Brazil',
  #     date_added: 'March 25, 2019',
  #     description: 'Lorem Ipsum etc etc.'
  #   )
  #   get :index
  #   expect(response).to have_http_status(200)
  #   expect(response.body).to include data.title
  #   expect(response.body).to include data.show_type
  #   expect(response.body).to include data.release_year
  #   expect(response.body).to include data.country
  #   expect(response.body).to include data.date_added
  #   expect(response.body).to include data.description
  # end

  # it 'GET /netlix_shows/:id' do
  #   data = NetflixShow.first
  #   request.accept = 'application/json'
  #   get :show, params: { id: data.id }
  #   response_body = JSON.parse(response.body)
  #   expect(response_body.fecth('id')).to eq(data.id)
  # end

  # context 'index' do
  #   it 'return status OK' do
  #     get netflix_shows_path
  #     expect(response).to have_http_status(200)
  #   end
  # end
#end

RSpec.describe 'NetflixShow', type: :request do
  #GET
  describe 'GET /netflix_shows' do
    #make HTTP get request before each example
    before {get '/netflix_shows', as: :json}
    it 'return all datas' do
      expect(response.body).not_to be_empty
    end
  
    it 'return status code 200 OK' do
      expect(response).to have_http_status(:ok)
    end
  end

  #POST
  describe 'POST /netflix_shows' do
    #valid payload
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
      
      #let(:params) {{title: 'Turma da Monica'}}
      before {post '/netflix_shows', params: new_data, as: :json}
      it 'return status code 201 created and 422 unprocessable_entity' do
        expect(response).to have_http_status(:created)

        post '/netflix_shows', params: new_data, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end


  #DELETE
  describe 'DELETE /netflix_shows/:id' do
    before {delete '/netflix_shows', params: {id: 1}}

    it 'returns status code 204' do
      expect(response).to have_http_status(:no_content)
    end
  end

end

