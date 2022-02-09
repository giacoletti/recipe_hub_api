RSpec.describe 'POST /api/recipes', type: :request do
  subject { response }

  let!(:user) { create(:user) }
  let(:credentials) { user.create_new_auth_token }

  describe 'as an authenticated user' do
    describe 'successfully' do
      before do
        post '/api/recipes', params: {
          recipe: {
            name: 'Fried rice with kimchi',
            instructions: 'Mix and shake it',
            ingredients: { name: 'sugar', unit: 'gram', amount: '200' },
            user: user.email
          }
        }, headers: credentials
        @recipe = Recipe.last
      end

      it { is_expected.to have_http_status :created }

      it 'is expected to create an instance of a Recipe' do
        expect(@recipe).to_not eq nil
      end

      it 'is expected to have saved the recipe in the database' do
        expect(@recipe.name).to eq 'Fried rice with kimchi'
      end

      it 'is expected to respond with a confirmation message' do
        expect(response_json['message']).to eq 'Your recipe is created for you!'
      end
    end
  end
end
