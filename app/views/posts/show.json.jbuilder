json.(@post, :id, :title, :text, :created_at, :updated_at)
json.author(@post.user, :id, :email, :name)
json.comments(@post.comments, :id, :user_id, :text, :created_at, :updated_at)
