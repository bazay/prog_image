RSpec.describe ProgImage::FileFetcher do
  subject(:service) { described_class.new key }

  include_context 'with file for upload'
  include_context 'with aws s3 connector'

  its(:key) { is_expected.to eq key }

  describe '#fetch_file' do
    subject { service.fetch_file }

    it { is_expected.to be_kind_of File }
  end

  describe '#fetch_file_url' do
    subject { service.fetch_file_url }

    it { is_expected.to include key }
  end

  describe '#file_exists?' do
    subject { service.file_exists? }

    it { is_expected.to be true }
  end
end
