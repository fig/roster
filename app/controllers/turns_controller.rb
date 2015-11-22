class TurnsController < ApplicationController

  def new
    @turn = Turn.new
  end

  def create
    @turn = Turn.new(turn_params)
    @turn.save ? redirect_to(@turn) : render('new')
  end

  def show
    @turn = Turn.find(params[:id])
  end

  def index
    @turns = Turn.all
  end

  def edit
    @turn = Turn.find(params[:id])
  end

  def update
    @turn = Turn.find(params[:id])
    @turn.update(turn_params) ? redirect_to(@turn) : render('edit')
  end

  def destroy
    @turn = Turn.find(params[:id])
    @turn.destroy

    redirect_to turns_path
  end

  private

  def turn_params
    params.require(:turn).permit(:name, :time_on, :time_off)
  end
end
