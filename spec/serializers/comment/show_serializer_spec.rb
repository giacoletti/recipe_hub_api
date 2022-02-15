RSpec.describe Comment::ShowSerializer, type: :serializer do
  let(:comment) { create(:comment) }
  let(:serialization) do
    ActiveModelSerializers::SerializableResource.new(
      comment,
      serializer: described_class
    )
  end

  subject { JSON.parse(serialization.to_json) }

  it 'is expected to wrap data in a key reflecting the resource name' do
    expect(subject.keys).to match ['comment']
  end

  it 'is expected to include relevant keys' do
    expected_keys = %w[body user]
    expect(subject['comment'].keys).to match expected_keys
  end

  it 'is expected to contain keys with specific data types' do
    expect(subject).to match(
      'recipe_ingredient' => {
        'body' => an_instance_of(String),
        'user' => an_instance_of(String)
      }
    )
  end
end
