Rspec.describe User, type: :model do
  describe 'Db table' do
    it { is_expected.to have_db_column(:name) }
    it { is_expected.to have_db_column(:email) }
  end
describe 'Validations' do
  
end


end

