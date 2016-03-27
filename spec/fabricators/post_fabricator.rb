Fabricator(:post) do
  user

  title { FFaker::Lorem.sentence(8) }
  text  { FFaker::Lorem.sentence(64) }
end
