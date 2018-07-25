RSpec.shared_context 'with aws s3 connector' do
  let(:aws_s3_connector_class) { ::ProgImage::Connectors::Aws::S3Connector }
  let(:stubbed_bucket) { Aws::S3::Bucket.new(stub_responses: true, name: bucket_name) }
  let(:bucket_name) { 'example-bucket' }
  let(:stubbed_connector) { instance_double(aws_s3_connector_class.to_s) }

  before { allow_any_instance_of(aws_s3_connector_class).to receive(:bucket).and_return stubbed_bucket }
end
