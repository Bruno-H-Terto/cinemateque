class Api::V1::MovieTheatersController < Api::V1::ApiController
  def show
    movie_theater = MovieTheater.find(params[:id])
    max_capacity = 0
    movie_theater.rooms.each do |room|
      max_capacity += room.capacity
    end
    response = movie_theater.as_json(except: [:created_at, :updated_at])
    render status: 200, json: { movie_theater: response, max_capacity: max_capacity }
  end
end