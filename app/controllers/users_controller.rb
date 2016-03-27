class UsersController < ApiController
  def index
    @users = User.order(created_at: :desc)
  end

  def create
    User.create!(create_user_params)

    render status: 201, nothing: true
  rescue StandardError => e
    render status: 400, json: {status: 'error', reason: e.message}
  end

private

  def create_user_params
    params.permit(:name, :email)
  end
end
