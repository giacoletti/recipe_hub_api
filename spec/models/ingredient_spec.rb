RSpec.describe Ingredient, type: :model do
  describe 'Database table' do
    it { is_expected.to have_db_column(:amount).of_type(:float) }
    it { is_expected.to have_db_column(:unit).of_type(:string) }
    it { is_expected.to have_db_column(:name).of_type(:string) }
  end

  describe 'Associations' do
    it { is_expected.to belong_to(:recipe) }
  end

  describe 'Factory' do
    it 'is expected to have a valid Factory' do
      expect(create(:ingredient)).to be_valid
    end
  end
end
