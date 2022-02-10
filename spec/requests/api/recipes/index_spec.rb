RSpec.describe 'GET /api/recipes', type: :request do
  subject { response }
  let!(:recipe) { 30.times { create(:recipe) } }
  let(:user) { create(:user) }
  let(:credentials) { user.create_new_auth_token }
  describe 'successfully' do
    before do
      get '/api/recipes'
    end

    it { is_expected.to have_http_status :ok }

    it 'is expected to return 30 recipes' do
      expect(response_json['recipes'].count).to eq 30
    end

    it 'is expected to respond the name of first recipe' do
      expect(response_json['recipes'].first['name']).to eq 'Fried rice with kimchi'
    end

    it 'is expected to respond the with right instructions' do
      expect(response_json['recipes'].first['instructions']).to eq 'Mix everything'
    end
  end

  describe 'filter recipes by user' do
    before do
      get '/api/recipes', headers: credentials
    end

    it { is_expected.to have_http_status :ok }

    it 'is expected to respond with a collection of recipes that belongs to a user' do
      expect(response_json['recipes'].all? { |recipe| recipe['user'] == user.email }).to eq true
    end
  end
end
