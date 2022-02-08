RSpec.describe Ingredients_recipe, type: :model do
  describe 'Database table' do
    it { is_expected.to have_db_column(:name).of_type(:string) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of :unit }
    it { is_expected.to validate_presence_of :amount }
  end

  describe 'Associations' do
    it { is_expected.to belongs_to(:ingredients) }
    it { is_expected.to belongs_to(:recipes) }
  end

  describe 'Factory' do
    it 'is expected to have a valid factory' do
      expect(create(:ingredients_recipe)).to be_valid
    end
  end
end
