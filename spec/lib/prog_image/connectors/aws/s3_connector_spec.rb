RSpec.describe ProgImage::Connectors::Aws::S3Connector do
  subject(:connector) { described_class.new }

  include_context 'with file for upload'
  include_context 'with aws s3 connector'

  describe '#fetch_file' do
    subject { connector.fetch_file key }

    it { is_expected.to be_kind_of File }
  end

  describe '#fetch_file_url' do
    subject { connector.fetch_file_url key }

    it { is_expected.to be_kind_of String }
    it { is_expected.to include key }
  end

  describe '#file_exists?' do
    subject { connector.file_exists? key }

    it { is_expected.to eq true }
  end

  describe '#upload_file' do
    subject { connector.upload_file uploaded_image_file, key }

    it { is_expected.to be true }

    context 'when request returns error' do
      let(:expected_errors) { [::Aws::S3::Errors::ServiceError, Timeout::Error] }

      before do
        allow(stubbed_bucket).to receive(:put_object).and_raise expected_errors.sample
        allow(connector).to receive(:bucket).and_return stubbed_bucket
      end

      # flashing test
      xit { is_expected.to be false }
    end
  end
end
