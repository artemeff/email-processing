class PostsController < ApiController
  def index
    @posts = Post.order(created_at: :desc)
  end

  def create
    Post.create!(create_post_params)

    render status: 201, nothing: true
  rescue StandardError => e
    render status: 400, json: {status: 'error', reason: e.message}
  end

  def show
    @post = Post.eager_load(:user, :comments).find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render status: 404, nothing: true
  end

private

  def create_post_params
    params.permit(:user_id, :title, :text)
  end
end
