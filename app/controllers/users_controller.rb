class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource only: [:edit, :update, :show]
  #Workaround for https://github.com/ryanb/cancan/issues/835

  # # GET /users/1
  # # GET /users/1.json
  # def show
  # end

  # # GET /users/1/edit
  # def edit
  # end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to '/' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:addresses_attributes => [:kind, :street, :city, :state, :zip, :country, :_destroy, :id])
    end
end