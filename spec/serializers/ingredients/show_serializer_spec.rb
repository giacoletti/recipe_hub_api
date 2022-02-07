RSpec.describe Ingredient::ShowSerializer, type: :serializer do
  let(:ingredient) { create(:ingredient) }

  let(:serialization) do
    ActiveModelSerializers::SerializableResource.new(ingredient, serializer: described_class)
  end

  subject { JSON.parse(serialization.to_json) }

  it 'is expected to wrap data in a key reflecting the resource name' do
    expect(subject.keys).to match ['ingredient']
  end

  it 'is expected to contain keys with specific data types' do
    expect(subject).to match(
      'ingredient' => {
        'amount' => an_instance_of(Float),
        'unit' => an_instance_of(String),
        'name' => an_instance_of(String)
      }
    )
  end
end
