Fabricator(:comment) do
  user
  post

  text { FFaker::Lorem.sentence(16) }
end
