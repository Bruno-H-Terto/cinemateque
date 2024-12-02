class ParticipationsController < ApplicationController
  def new
    @actor = Actor.find(params[:actor_id])
    @participation = @actor.participations.build
  end

  def create
    @actor = Actor.find(params[:actor_id])
    @participation = @actor.participations.build(participation_params)

    if @participation.save
      redirect_to @actor, notice: 'Participação adicionada com sucesso!'
    else
      flash[:alert] = 'Não foi possível adicionar a participação'
      render 'actors/show', status: :unprocessable_entity
    end
  end

  private

  def participation_params
    params.require(:participation).permit(:movie, :name)
  end
end