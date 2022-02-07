RSpec.describe 'GET /api/recipes', type: :request do
  subject { response }
  let!(:recipe) { create(:recipe) }
  describe 'successfully' do
    before do
      get '/api/recipes'
    end

    it { is_expected.to have_http_status :ok }

    it 'is expected to respond the title of first recipe' do
      expect(response_json['recipes'].first['title']).to eq 'Fried rice with kimchi'
    end

    it 'is expected to respond the with right instructions' do
      expect(response_json['recipes'].first['instructions']).to eq 'Mix everything'
    end
  end
end
