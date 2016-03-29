class CommentCrypto
  DELIMITER = '.'

  def self.encrypt(user, post, email_domain)
    hash = SymmetricEncryption.encrypt([user.id, post.id].join(DELIMITER))
    "#{hash}@#{email_domain}"
  end

  def self.decrypt(email)
    hash = email.split('@').first
    user_id, post_id = SymmetricEncryption.decrypt(hash).split(DELIMITER)
    {user_id: user_id, post_id: post_id}
  end
end
