RSpec.describe Comment, type: :model do
  describe 'DB table' do
    it { is_expected.to have_db_column(:body).of_type(:text) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of :body }
  end

  describe 'Associations' do
    it { is_expected.to belong_to(:recipe) }
    it { is_expected.to belong_to(:user) }
  end

  describe 'Factory' do
    it 'is expected to have valid factory' do
      expect(create(:comment)).to be_valid
    end
  end
end
