RSpec.describe ApplicationApi, type: :request do
  describe 'GET /api/version' do
    subject { decoded_json_response }

    let(:path) { build_api_path(version: '', path: 'version') }
    let(:version) { ProgImage::VERSION }
    let(:latest_api_version) { configatron.api.latest_version.call }

    before { dispatch path: path }

    its(['version']) { is_expected.to eq version }
    its(['latest_api_version']) { is_expected.to eq latest_api_version }
  end
end
