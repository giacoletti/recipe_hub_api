RSpec.describe 'GET /api/recipes', type: :request do
  describe 'successfully' do
    subject { response }

    before do
      get '/api/recipes'
    end

    it { is_expected.to have_http_status :ok }

    it 'is expected to respond with an empty array' do
      expect(response_json['recipes'].first['title']).to eq 'Fried rice with kimchi'
    end
  end
end
