class TurnsController < ApplicationController

  def new
    @turn = Turn.new
    @turns = Turn.all.order updated_at: :desc
  end

  def create
    @turn = Turn.new(turn_params)
    @turn.save ? redirect_to action: 'new') : render('new')
  end

  def show
    @turn = Turn.find(params[:id])
  end

  def index
    @turns = Turn.all.order :name
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
