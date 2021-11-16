class NetflixShowsController < ApplicationController
   before_action :set_data, only: [:show]

   def index
      @datas = NetflixShow.order('release_year DESC')
      render json: @datas#, only: [:id, :title, :genre, :year, :country, :published_at, :description]
   end

   def show
      render json: @data
   end

   private
      def set_data
         @data = NetflixShow.find(params[:id])
      end
end
