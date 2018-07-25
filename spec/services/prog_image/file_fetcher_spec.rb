RSpec.describe ProgImage::FileFetcher do
  subject(:service) { described_class.new key }

  include_context 'with file for upload'
  include_context 'with aws s3 connector'

  its(:key) { is_expected.to eq key }

  describe '#fetch' do
    subject { service.fetch }

    its(:public_url) { is_expected.to include key }
  end
end
