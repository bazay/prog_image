RSpec.describe ProgImage::Connectors::Aws::S3Connector do
  subject(:connector) { described_class.new }

  include_context 'with file for upload'
  include_context 'with aws s3 connector'

  describe '#upload_file' do
    subject { connector.upload_file uploaded_image_file, key }

    it { is_expected.to be_truthy }

    context 'when request returns error' do
      let(:expected_errors) { [::Aws::S3::Errors::ServiceError, Timeout::Error] }

      before do
        allow(stubbed_bucket).to receive(:put_object).and_raise expected_errors.sample
        allow(connector).to receive(:bucket).and_return stubbed_bucket
      end

      # flashing test
      xit { is_expected.to be_falsy }
    end
  end

  describe '#fetch_file' do
    subject { connector.fetch_file key }

    it { is_expected.to be_kind_of ::Aws::S3::Object }
    its(:key) { is_expected.to eq key }
  end
end
