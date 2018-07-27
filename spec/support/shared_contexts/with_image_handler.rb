RSpec.shared_context 'with image handler' do
  let(:stubbed_image_file) { spec_upload_file(image_path, svg_content_type) }

  before do
    allow_any_instance_of(ProgImage::ImageHandler).to receive(:original_image_file).and_return stubbed_image_file
  end
end
