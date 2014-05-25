#
class TurnsController < ApplicationController
  def new
    @turn = Turn.new
  end

  def create
    @turn = Turn.new(turn_params)

    if @turn.save
      redirect_to @turn
    else
      render 'new'
    end
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

    if @turn.update(turn_params)
      redirect_to @turn
    else
      render 'edit'
    end
  end

  private

  def turn_params
    params.require(:turn).permit(:name, :time_on, :time_off)
  end
end
