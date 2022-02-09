RSpec.describe User, type: :model do
  describe 'Db table' do
    it { is_expected.to have_db_column(:name) }
    it { is_expected.to have_db_column(:email) }
    it { is_expected.to have_db_column(:uid) }
    it { is_expected.to have_db_column(:provider) }
    it { is_expected.to have_db_column(:encrypted_password) }
  end
  describe 'Validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :email }
  end
  describe 'Factory' do
    it 'is expected to have a valid factory' do
      expect(create(:user)).to be_valid
    end
  end
end
