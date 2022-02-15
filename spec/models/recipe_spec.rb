RSpec.describe Recipe, type: :model do
  describe 'Database table' do
    it { is_expected.to have_db_column(:name).of_type(:string) }
    it { is_expected.to have_db_column(:instructions).of_type(:text) }
    it { is_expected.to have_db_column(:forks_count).of_type(:integer) }
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

  describe 'Image' do
    it 'is expected to be attached' do
      subject.image.attach(
        io: File.open(fixture_path + 'carbonara.jpeg'),
        filename: 'carbonara.jpeg',
        content_type: 'image/jpeg'
      )
      expect(subject.image).to be_attached
    end
  end

  describe '#fork' do
    let(:ingredient) { create(:ingredient) }
    let(:original_user) { create(:user, name: 'Thomas') }
    let(:original_recipe) { create(:recipe, user: original_user) }
    let!(:recipe_ingredient) { create(:recipe_ingredient, ingredient: ingredient, recipe: original_recipe) }
    let(:new_user) { create(:user, name: 'Elvita') }

    it { is_expected.to respond_to(:fork).with(1).argument }

    it 'is expected to create a new instance of Recipe' do
      expect { original_recipe.fork(new_user) }.to change { Recipe.count }.from(1).to(2)
    end
  end
end
