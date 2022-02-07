RSpec.describe Recipe::IndexSerializer, type: :serializer do
  let(:recipes) { create_list(:recipe, 30) }

  let(:serialization) do
    ActiveModelSerializers::SerializableResource.new(
      recipes,
      each_serializer: described_class
    )
  end

  subject { JSON.parse(serialization.to_json) }

  it 'is expected to wrap data in a key reflecting the resource name' do
    expect(subject.keys).to match ['recipes']
  end
  it 'is expected to include relevant keys' do
    expected_keys = %w[id title instructions created_at updated_at]
    expect(subject['recipes'].first.keys).to match expected_keys
  end
  it 'is expected to contain keys with values of specific data types' do
    expect(subject['recipes'].first).to match(
      {
        'id' => an_instance_of(Integer),
        'title' => an_instance_of(String),
        'instructions' => an_instance_of(String),
        'created_at' => an_instance_of(String),
        'updated_at' => an_instance_of(String)

      }
    )
  end
end
