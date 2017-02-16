class BaseRostersController < ApplicationController
  before_action :set_base_roster, only: [:show, :edit, :update, :destroy]

  # GET /base_rosters
  # GET /base_rosters.json
  def index
    @base_rosters = BaseRoster.all
  end

  # GET /base_rosters/1
  # GET /base_rosters/1.json
  def show
  end

  # GET /base_rosters/new
  def new
    @base_roster = BaseRoster.new
  end

  # GET /base_rosters/1/edit
  def edit
  end

  # POST /base_rosters
  # POST /base_rosters.json
  def create
    @base_roster = BaseRoster.new(base_roster_params)

    respond_to do |format|
      if @base_roster.save
        @line = @base_roster.lines.build(number: '1')
        format.html { redirect_to @base_roster, notice: 'Base roster was successfully created.' }
        format.json { render :show, status: :created, location: @base_roster }
      else
        format.html { render :new }
        format.json { render json: @base_roster.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /base_rosters/1
  # PATCH/PUT /base_rosters/1.json
  def update
    respond_to do |format|
      if @base_roster.update(base_roster_params)
        format.html { redirect_to @base_roster, notice: 'Base roster was successfully updated.' }
        format.json { render :show, status: :ok, location: @base_roster }
      else
        format.html { render :edit }
        format.json { render json: @base_roster.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /base_rosters/1
  # DELETE /base_rosters/1.json
  def destroy
    @base_roster.destroy
    respond_to do |format|
      format.html { redirect_to base_rosters_url, notice: 'Base roster was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.

    def set_base_roster
      @base_roster = BaseRoster.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def base_roster_params
      params.require(:base_roster).permit(:name, :version, :depot, :link, :duration, :commencement_date)
    end
end
