class ApplicationController < ActionController::Base
  before_filter :configure_permitted_parameters, if: :devise_controller?

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :company_id) }
  end

  private

  def current_ability
  	@current_ability ||= case
                       when current_user
                         UserAbility.new(current_user)
                       when current_admin
                         AdminAbility.new(current_admin)
                       when current_company_user
                         CompanyUserAbility.new(current_company_user)
                       else
                         GuestAbility.new
                       end  
                   end
end