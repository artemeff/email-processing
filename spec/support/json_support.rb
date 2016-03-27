module JSONSupport
  def response_json
    JSON.load(response.body)
  end
end
