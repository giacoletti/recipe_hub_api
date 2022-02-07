RSpec.describe Recipe::IndexSerializer, type: :serializer do
  let(:recipes) { create_list(:recipe, 10) }

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
end
