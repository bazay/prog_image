RSpec.describe ProgImage::FileUploader do
  subject(:service) { described_class.new uploaded_image_file }

  include_context 'with file for upload'
  include_context 'with aws s3 connector'

  before { allow(service).to receive(:key).and_return key }

  describe '#upload' do
    subject { service.upload }

    it { is_expected.to eq key }

    context 'when upload was not successful' do
      before do
        allow(stubbed_connector).to receive(:upload_file).and_return false
        allow(service).to receive(:connector).and_return stubbed_connector
      end

      it { is_expected.to be_falsey }
    end
  end
end
