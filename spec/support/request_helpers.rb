module RequestHelpers
  def json_response
    @json ||= JSON.parse(last_response.body)
  end
end
