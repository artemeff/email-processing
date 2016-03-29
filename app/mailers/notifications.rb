class Notifications < ApplicationMailer
  def new_comment(post, author, commenter, comment)
    @post = post
    @author = author
    @commenter = commenter
    @comment = comment

    mail to: author.email, reply_to: CommentCrypto.encrypt(author, post, 'dev')
  end
end
