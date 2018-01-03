class MartiansController < ApplicationController
  before_action :set_martian, only: [:show, :edit, :update, :destroy]

  # GET /martians
  # GET /martians.json
  def index
    @martians = Martian.all
    respond_to do |format|
      format.html {}
      format.json { render json: @martians, each_serializer: MartianSerializer }
    end
  end

  # GET /martians/1
  # GET /martians/1.json
  def show
    respond_to do |format|
      format.html {}
      format.json { render json: @martian }
    end
  end

  # GET /martians/new
  def new
    @martian = Martian.new
  end

  # GET /martians/1/edit
  def edit
  end

  # POST /martians
  # POST /martians.json
  def create
    @martian = Martian.new(martian_params)

    respond_to do |format|
      if @martian.save
        format.html { redirect_to @martian, notice: 'Martian was successfully created.' }
        format.json { render :show, status: :created, location: @martian }
      else
        format.html { render :new }
        format.json { render json: @martian.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /martians/1
  # PATCH/PUT /martians/1.json
  def update
    respond_to do |format|
      if @martian.update(martian_params)
        format.html { redirect_to @martian, notice: 'Martian was successfully updated.' }
        format.json { render :show, status: :ok, location: @martian }
      else
        format.html { render :edit }
        format.json { render json: @martian.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /martians/1
  # DELETE /martians/1.json
  def destroy
    @martian.destroy
    respond_to do |format|
      format.html { redirect_to martians_url, notice: 'Martian was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_martian
      @martian = Martian.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def martian_params
      params.require(:martian).permit(:name, :age)
    end
end
