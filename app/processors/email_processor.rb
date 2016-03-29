class EmailProcessor
  def initialize(email)
    @from = email.from
    @to = email.to
    @comment = email.body
  end

  def process
    params = CommentCrypto.decrypt(@to.first[:email])
    user = User.find(params[:user_id])

    Post.find(params[:post_id]).comments.create!(user: user, text: @comment)
  rescue StandardError
    :error
  end
end
