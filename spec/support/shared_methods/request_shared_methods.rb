module RequestSharedMethods
  def app
    ProgImage::ApplicationApi
  end

  def dispatch(method: :get, path: '/', params: {})
    send(method, path, params)
  end

  def decoded_json_body(request)
    JSON.parse(request.body)
  end

  def build_api_path(version: 'v1.0', path: '')
    "/api/#{version}" + path
  end
end
