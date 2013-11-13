class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  
  #Workaround for https://github.com/ryanb/cancan/issues/835
  load_and_authorize_resource only: [:show, :edit, :update]

  # # GET /users/1
  # def show
  # end

  # # GET /users/1/edit
  # def edit
  # end

  # # PATCH/PUT /users/1
  def update
      if @user.update(user_params)
        redirect_to '/', notice: 'Address updated.'
      else
        render action: 'edit'
      end
    end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:locatables_attributes => [ :id, :_destroy, :kind, :address_attributes => [:street, :city, :state, :zip, :country, :_destroy, :id, :latitude, :longitude] ])
    end
end