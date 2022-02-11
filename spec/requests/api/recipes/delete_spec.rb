RSpec.describe 'DELETE /api/recipes/:id', type: :request do
  subject { response }
  let!(:recipe) { create(:recipe) }
  let(:user) { create(:user) }
  let(:credentials) { user.create_new_auth_token }
  describe 'successfully' do
    describe 'as an authenticated user' do
      before do
        delete "/api/recipes/#{recipe.id}", headers: credentials
      end

      it { is_expected.to have_http_status :accepted }

      it 'is expected to respond with a message' do
        expect(response_json['message']).to eq 'Your recipe has been deleted!'
      end

      it 'is expected to have the recipe deleted from the DB' do
        expect { Recipe.find(recipe.id) }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe 'unsuccessfully' do
    describe 'as an authenticated user' do
      before do
        delete "/api/recipes/ASJDOSAIJOIJ", headers: credentials
      end

      it { is_expected.to have_http_status :not_found }

      it 'is expected to respond with an error message' do
        expect(response_json['message']).to eq 'Recipe not found'
      end
    end
    
    describe 'as an anonymous user' do
      before do
        delete "/api/recipes/#{recipe.id}", headers: nil
      end

      it { is_expected.to have_http_status :unauthorized }

      it 'is expected to respond with a message' do
        expect(response_json['errors'].first).to eq 'You need to sign in or sign up before continuing.'
      end
    end
  end
end
