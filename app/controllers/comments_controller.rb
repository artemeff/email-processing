class CommentsController < ApiController
  def create
    comment = Comment.create!(create_comment_params)

    Notifications.new_comment(comment.post,
      comment.post.user, comment.user, comment).deliver_now!

    render status: 201, nothing: true
  rescue StandardError => e
    render status: 400, json: {status: 'error', reason: e.message}
  end

private

  def create_comment_params
    params.permit(:post_id, :user_id, :text)
  end
end
