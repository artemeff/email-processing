class Notifications < ApplicationMailer
  def new_comment(post, author, commenter, comment)
    @post = post
    @author = author
    @commenter = commenter
    @comment = comment

    mail to: author.email, reply_to: make_reply_to(post)
  end

private

  def make_reply_to(post)
    "comment.#{post.id}@dev"
  end
end
