RSpec.shared_context 'with file for upload' do
  let(:key) { '12345/example.png' }

  let(:image_path) { spec_file_path('bcg_digital_ventures.svg') }
  let(:image_file) { spec_upload_file(image_path, svg_content_type) }
  let(:uploaded_image_file) { api_uploaded_file(image_path, svg_content_type) }
  let(:svg_content_type) { 'image/svg+xml' }

  let(:text_path) { spec_file_path('example.txt') }
  let(:text_file) { spec_upload_file(text_path, text_content_type) }
  let(:uploaded_text_file) { api_uploaded_file(text_path, text_content_type) }
  let(:text_content_type) { 'text/plain' }
end
