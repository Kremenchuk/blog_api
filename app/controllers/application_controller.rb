class ApplicationController < ActionController::API
  before_action :authenticate_request
  # attr_reader :current_user


  private


  rescue_from ActiveRecord::RecordInvalid, ActiveRecord::RecordNotFound, with: ->(error) do
    render json: { error: error }, status: 400
  end


  def authenticate_request
    @current_user = AuthorizeApiRequest.call(request.headers).result
    render json: { error: 'Not Authorized' }, status: 401 unless @current_user
  end
end
