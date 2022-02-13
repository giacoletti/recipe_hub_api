RSpec.describe Recipe::ShowSerializer, type: :serializer do
  let(:recipe) { create(:recipe) }
  let(:serialization) do
    ActiveModelSerializers::SerializableResource.new(
      recipe,
      serializer: described_class
    )
  end

  subject { JSON.parse(serialization.to_json) }

  it 'is expected to wrap data in a key reflecting the resource name' do
    expect(subject.keys).to match ['recipe']
  end

  it 'is expected to include relevant keys' do
    expected_keys = %w[id name instructions ingredients created_at owner]
    expect(subject['recipe'].keys).to match expected_keys
  end

  it 'is expected to contain keys with values of specific data types' do
    expect(subject).to match(
      'recipe' => {
        'id' => an_instance_of(Integer),
        'name' => an_instance_of(String),
        'instructions' => an_instance_of(String),
        'ingredients' => an_instance_of(Array),
        'created_at' => an_instance_of(String),
        'owner' => an_instance_of(String)
      }
    )
  end
end
