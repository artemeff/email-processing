class EmailProcessor
  def initialize(email)
    @from = email.from
    @to = email.to
    @comment = email.body
  end

  def process
    post_id = parse_params(@to.first[:email])
    user = User.find_by!(email: @from[:email])

    Post.find(post_id).comments.create!(user: user, text: @comment)
  rescue StandardError
    :error
  end

private

  # parse_params('comment.42@dev.com')
  # => '42'
  def parse_params(to)
    to.split('@').first.split('.')[1]
  end
end
