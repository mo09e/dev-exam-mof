class PropertiesController < ApplicationController
  before_action :set_property, only: [:show, :edit, :update, :destroy]

  # GET /properties
  # GET /properties.json
  def index
    @properties = Property.all
  end

  # GET /properties/1
  # GET /properties/1.json
  def show
    @stations = @property.stations
  end

  # GET /properties/new
  def new
    @property = Property.new
    2.times { @property.stations.build }
  end

  # GET /properties/1/edit
  def edit
    if @property.stations.blank?
      @property.stations.build
    else
      station_blank_checker
    end
  end

  # POST /properties
  # POST /properties.json
  def create
    @property = Property.create(property_params)
    if params[:back]
      render :new
    elsif @property.save
      redirect_to properties_path, notice: "登録しました"
    elsif @property.stations.blank?
      new_station_inputs
      render :new
    else
      station_blank_checker
      render :new
    end
  end

  # PATCH/PUT /properties/1
  # PATCH/PUT /properties/1.json
  def update
    if @property.update(property_params)
      redirect_to properties_path, notice: "編集しました"
    else
      render :edit
    end
  end

  # DELETE /properties/1
  # DELETE /properties/1.json
  def destroy
    @property.destroy
    redirect_to properties_path, notice: "物件を削除しました"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_property
      @property = Property.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def property_params
      params.require(:property).permit(:name, :price, :address, :age, :remark, stations_attributes: [:route, :name, :property_id, :time, :id, :_destroy])
    end

    def station_blank_checker
      @property.stations.each do |station|
        unless station.name.blank?
          @property.stations.build
          break
        end
      end
    end
end
