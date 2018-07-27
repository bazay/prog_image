RSpec.shared_context 'with aws s3 connector' do
  let(:aws_s3_connector_class) { ::ProgImage::Connectors::Aws::S3Connector }
  let(:stubbed_bucket) { Aws::S3::Bucket.new(stub_responses: true, name: bucket_name) }
  let(:stubbed_client) { Aws::S3::Client.new(stub_responses: true) }
  let(:bucket_name) { 'example-bucket' }
  let(:stubbed_connector) { instance_double(aws_s3_connector_class.to_s) }

  before do
    allow_any_instance_of(aws_s3_connector_class).to receive(:bucket).and_return stubbed_bucket
    allow_any_instance_of(aws_s3_connector_class).to receive(:client).and_return stubbed_client
  end
end
