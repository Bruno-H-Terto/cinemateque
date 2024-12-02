class ActorsController < ApplicationController
  def index
    @actors = Actor.all
  end

  def show
    @actor = Actor.find(params[:id])
  end

  def new
    @actor = Actor.new
  end

  def create
    @actor = Actor.new(actor_params)

    if @actor.save
      redirect_to @actor, notice: "Ator/Atriz #{@actor.name} cadastrado com sucesso!"
    else
      flash.alert = 'Não foi possível cadastrar o artista.'
      render :new, statuts: :unprocessable_entity
    end
  end

  private

  def actor_params
    params.require(:actor).permit(:name, :birth_date, :nationality)
  end
end