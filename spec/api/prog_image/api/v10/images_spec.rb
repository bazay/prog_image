RSpec.describe ProgImage::Api::V10::Images, type: :request do
  let(:request) { dispatch(method: method, path: path, params: params) }
  let(:path) { build_api_path(path: '/images') }

  include_context 'with file for upload'
  include_context 'with aws s3 connector'
  include_context 'with image handler'

  describe 'POST /api/v1.0/images' do
    let(:method) { :post }
    let(:params) { { image_file: image_file } }

    it_behaves_like 'json body with keys', 'key', 'public_url'
  end

  describe 'GET /api/v1.0/images' do
    let(:method) { :get }
    let(:path) { build_api_path(path: '/images') }
    let(:params) { { key: key } }

    it_behaves_like 'json body with keys', 'key', 'public_url'
  end
end
