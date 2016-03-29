class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  before_action :restrict_organization_access

  respond_to :json

  private

  def restrict_organization_access
    @organization = Organization.find_by(auth_token: request.headers['Authorization'])
    render json: { message: 'Unauthorized access' }, status: 401 unless @organization
  end
end
