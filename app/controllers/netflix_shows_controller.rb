# frozen_string_literal: true

class NetflixShowsController < ApplicationController
  before_action :set_data, only: %i[show update destroy]

  # GET /netflix_shows
  def index
    @datas = NetflixShow.where(nil) # cria um scope anônimo
    filtering_params(params).each do |key, value|
      @datas = @datas.public_send("filter_by_#{key}", value) if value.present?
    end

    @datas = @datas.order('release_year DESC')

    render json: @datas
  end

  # GET /netflix_shows/1
  def show
    render json: @data
  end

  # POST /netflix_shows
  def create
    @data = NetflixShow.new(data_params)

    if @data.save
      render json: @data, status: :created, location: @data
    else
      render json: @data.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /netflix_shows/1
  def update
    if @data.update(data_params)
      render json: @data
    else
      render json: @data.errors, status: :unprocessable_entity
    end
  end

  # DELETE /netflix_shows/1
  def destroy
    @data.destroy
  end

  private

  def set_data
    @data = NetflixShow.find(params[:id])
  end

  def data_params
    params.permit(:title, :show_type, :release_year, :country, :date_added, :description)
  end

  # Lista com os nomes dos params que serão filtrados
  def filtering_params(params)
    params.slice(:year, :genre, :country)
  end
end
