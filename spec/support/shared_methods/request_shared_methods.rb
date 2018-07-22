module RequestSharedMethods
  def dispatch(method: :get, path: '/', params: {})
    send(method, path, params)
  end

  def build_api_path(version: 'v1.0', path: '')
    "/api/#{version}" + path
  end

  def decoded_json_response(text = response.body)
    ActiveSupport::JSON.decode text
  end
end
