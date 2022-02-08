RSpec.describe IngredientsRecipe, type: :model do
  describe 'Database table' do
    it { is_expected.to have_db_column(:unit).of_type(:string) }
    it { is_expected.to have_db_column(:amount).of_type(:float) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of :unit }
    it { is_expected.to validate_presence_of :amount }
  end

  describe 'Associations' do
    it { is_expected.to belong_to(:ingredient) }
    it { is_expected.to belong_to(:recipe) }
  end

  describe 'Factory' do
    it 'is expected to have a valid factory' do
      expect(create(:ingredients_recipe)).to be_valid
    end
  end
end
