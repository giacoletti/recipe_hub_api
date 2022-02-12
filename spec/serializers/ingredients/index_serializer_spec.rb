RSpec.describe Ingredient::IndexSerializer, type: :serializer do
  let(:ingredients) { create_list(:ingredient, 20) }

  let(:serialization) do
    ActiveModelSerializers::SerializableResource.new(
      ingredients,
      each_serializer: described_class
    )
  end

  subject { JSON.parse(serialization.to_json) }

  it 'is expected to wrap data in a key reflecting the resource name' do
    expect(subject.keys).to match ['ingredients']
  end

  it 'is expected to include relevant keys' do
    expected_keys = %w[id name]
    expect(subject['ingredients'].first.keys).to match expected_keys
  end

  it 'is expected to contain keys with values of specific data types' do
    expect(subject['ingredients'].first).to match(
      {
        'id' => an_instance_of(Integer),
        'name' => an_instance_of(String)
      }
    )
  end
end
