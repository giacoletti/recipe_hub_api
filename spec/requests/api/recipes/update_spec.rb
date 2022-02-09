RSpec.describe 'PUT /api/recipes/:id', type: :request do
  let(:recipe) { create(:recipe) }

  subject { response }

  describe 'successfully' do
    before do
      put "/api/recipes/#{recipe.id}", params: { recipe: { name: 'My new recipie' } }
    end

    it { is_expected.to have_http_status 200 }

    it 'is expected to responde with a message' do
      expect(response_json['message']).to eq 'Your recipe was updated.'
    end
  end

  describe 'unsuccessfully' do
    describe 'with non-existent id' do
      before do
        put '/api/recipes/9999999', params: { recipe: { name: 'My new recipie' } }
      end

      it { is_expected.to have_http_status 404 }

      it 'is expected to respond with error message' do
        expect(response_json['message']).to eq 'Recipe not found'
      end
    end
  end
end
