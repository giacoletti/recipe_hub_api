RSpec.describe 'DELETE /api/recipes/:id', type: :request do
  subject { response }
  let!(:recipe) { create(:recipe) }
  describe 'successfully' do
    before do
      delete "/api/recipes/#{recipe.id}"
    end

    it { is_expected.to have_http_status :accepted }

    it 'is expected to respond with a message' do
      expect(response_json['message']).to eq 'Your recipe has been deleted!'
    end

    it 'is expected to have the recipe deleted from the DB' do
      expect(Recipe.find(recipe.id)).to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
