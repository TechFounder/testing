class VehiclesController < ApplicationController
  before_action :set_vehicle, only: [:show, :edit, :update, :destroy]
    load_and_authorize_resource except: [:create, :update]
    #https://github.com/ryanb/cancan/issues/835

    def index
    	@vehicles = Vehicle.all
    end

    def new 
      @vehicle = Vehicle.new
    end

    def create
    	@vehicle = Vehicle.new(vehicle_params)
    	@vehicle.save
    	flash[:notice] = "The new vehicle has been created!"
    	render :action => "show"
    end

    def show
    	@vehicle = Vehicle.find(params[:id])
    end

    def edit
    	@vehicle
    end

    def update
    	@vehicle.update_attributes(vehicle_params)
    	flash[:notice] = "New vehicle has been updated"
    	redirect_to @vehicle
    end

    def destroy
    	@vehicle = Vehicle.find(params[:id])
    	@vehicle.destroy
    	flash[:notice] = "Vehicle has been destroyed"
    	redirect_to "/"
    end	

    private

  	def vehicle_params
  	  params.require(:vehicle).permit!
  	end

  	def set_vehicle
  	  @vehicle = Vehicle.find(params[:id])
  end
end
