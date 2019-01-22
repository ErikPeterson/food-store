module RequestHelper
  def response_json
    JSON.parse(response.body).with_indifferent_access
  end
end
