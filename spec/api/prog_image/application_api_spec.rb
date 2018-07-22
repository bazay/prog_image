RSpec.describe ProgImage::ApplicationApi, type: :request do
  describe 'GET /api/version' do
    subject(:request) { decoded_json_body(dispatch(path: path)) }

    let(:path) { build_api_path(version: '', path: 'version') }
    let(:version) { ProgImage.version }
    let(:latest_api_version) { configatron.api.latest_version.call }

    its(['version']) { is_expected.to eq version }
    its(['latest_api_version']) { is_expected.to eq latest_api_version }
  end
end
