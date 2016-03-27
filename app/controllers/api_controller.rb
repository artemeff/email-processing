class ApiController < ActionController::Base
  protect_from_forgery with: :null_session
  before_action :set_default_format
  respond_to :json

private

  def set_default_format
    request.format = 'json' unless params[:format]
  end
end
