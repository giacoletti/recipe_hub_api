RSpec.describe Recipe, type: :model do
  describe 'Database table' do
    it { is_expected.to have_db_column(:title).of_type(:string) }
    it { is_expected.to have_db_column(:instructions).of_type(:text) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of :title }
    it { is_expected.to validate_presence_of :instructions }
  end

  describe 'Associations' do
    # it { is_expected.to have_many(:ingredients) }
    it { should have_and_belong_to_many(:ingredients) }
  end

  describe 'Factory' do
    it 'is expected to have be valid' do
      expect(create(:recipe)).to be_valid
    end
  end
end
