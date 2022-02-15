RSpec.describe 'POST /api/recipes', type: :request do
  let(:original_recipe) { create(:recipe, user: original_user) }
  let(:original_user) { create(:user, name: 'Thomas') }
  let(:new_user) { create(:user, name: 'Elvita') }
  let(:credentials) { new_user.create_new_auth_token }

  describe 'successful' do
    before do
      post '/api/recipes', params: { recipe: { id: original_recipe.id, fork: true } }, headers: credentials
    end

    it 'is expected to respond with a success message' do
      expect(response_json['message']).to eq 'The recipe was successfully forked and saved in uyour collection'
    end
  end

  describe 'unsuccessful' do
    before do
      post '/api/recipes', params: { recipe: { id: 999, fork: true } }, headers: credentials
    end

    it 'is expected to respond with an error message' do
      expect(response_json['message']).to eq 'Recipe not found'
    end
  end
end
