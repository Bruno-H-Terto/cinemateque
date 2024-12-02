class Api::V1::MovieTheatersController < Api::V1::ApiController
  def show
    movie_theater = MovieTheater.find(params[:id])
    render status: 200, json: movie_theater
  end
end