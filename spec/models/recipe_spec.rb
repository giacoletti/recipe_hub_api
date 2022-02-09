RSpec.describe Recipe, type: :model do
  describe 'Database table' do
    it { is_expected.to have_db_column(:name).of_type(:string) }
    it { is_expected.to have_db_column(:instructions).of_type(:text) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :instructions }
  end

  describe 'Associations' do
    it { is_expected.to have_many(:ingredients) }
  end

  describe 'Factory' do
    it 'is expected to have a valid factory' do
      expect(create(:recipe)).to be_valid
    end
  end
end
