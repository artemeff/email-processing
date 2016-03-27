Fabricator(:mail, from: OpenStruct) do
  to [{ full: 'to_user@email.com', email: 'to_user@email.com', token: 'to_user', host: 'email.com', name: nil }]
  from({ token: 'from_user', host: 'email.com', email: 'from_email@email.com', full: 'From User <from_user@email.com>', name: 'From User' })
  subject 'email subject'
  body 'Hello!'
  headers []
end
