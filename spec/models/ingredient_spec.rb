RSpec.describe Ingredient, type: :model do
  describe 'Database table' do
    it { is_expected.to have_db_column(:name).of_type(:string) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of :name }
  end

  describe 'Associations' do
    it { is_expected.to have_many(:recipe_ingredients) }
    it { is_expected.to have_many(:recipes) }
  end

  describe 'Factory' do
    it 'is expected to have a valid factory' do
      expect(create(:ingredient)).to be_valid
    end
  end
end
