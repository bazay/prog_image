RSpec.shared_examples_for 'json body with keys' do |*keys|
  subject { decoded_json_body(request) }

  it 'contains the expected keys' do
    keys.each do |key|
      is_expected.to have_key key
    end
  end
end
