RSpec.describe 'POST /api/recipes', type: :request do
  subject { response }

  let(:user) { create(:user) }
  let(:credentials) { user.create_new_auth_token }
  let!(:rice) { create(:ingredient, name: 'Rice') }
  let!(:kimchi) { create(:ingredient, name: 'Kimchi') }

  describe 'as an authenticated user' do
    describe 'successfully' do
      before do
        post '/api/recipes', params: {
          recipe: {
            name: 'Fried rice with kimchi',
            instructions: 'Mix and shake it',
            ingredients_attributes: [
              { ingredient_id: rice.id, unit: 'gram', amount: '2000' },
              { ingredient_id: kimchi.id, unit: 'gram', amount: '2000' }
            ],
            image: "data:image/png;base64,/9j/4AAQSkZJRgABAQEASABIAAD/4gxYSUNDX1BST0ZJTEUAAQEAAAxITGlubwIQAABtbnR"
          }
        }, headers: credentials
        @recipe = Recipe.last
      end

      it { is_expected.to have_http_status :created }

      it 'is expected to create an instance of a Recipe' do
        expect(@recipe).to_not eq nil
      end

      it 'is expected to attach the image' do
        # binding.pry
        expect(@recipe.image).to be_attached
      end

      it 'is expected to have saved the recipe in the database' do
        expect(@recipe.name).to eq 'Fried rice with kimchi'
      end

      it 'is expected to respond with a confirmation message' do
        expect(response_json['message']).to eq 'Your recipe has been created'
      end

      it 'is expected to have saved the recipe with the user associated' do
        expect(@recipe.user.name).to eq user.name
      end

      it 'is expected to associate recipe with ingredients' do
        expect(@recipe.ingredients.size).to eq 2
      end
    end

    describe 'unsuccessfully' do
      describe 'due to missing params' do
        before do
          post '/api/recipes', params: {}, headers: credentials
        end

        it { is_expected.to have_http_status :unprocessable_entity }

        it 'is expected to respond with an error message' do
          expect(response_json['message']).to eq 'Recipe is missing'
        end
      end

      describe 'due to missing recipe name' do
        before do
          post '/api/recipes', params: {
            recipe: {
              instructions: 'Mix and shake it',
              ingredients_attributes: [
                { ingredient_id: rice.id, unit: 'gram', amount: '2000' }
              ]
            }
          }, headers: credentials
        end

        it { is_expected.to have_http_status :unprocessable_entity }

        it 'is expected to respond with an error message' do
          expect(response_json['message']).to eq "Name can't be blank"
        end
      end

      describe 'due to missing recipe instructions' do
        before do
          post '/api/recipes', params: {
            recipe: {
              name: 'Spaghetti bolognese',
              ingredients_attributes: [
                { ingredient_id: rice.id, unit: 'gram', amount: '2000' }
              ]
            }
          }, headers: credentials
        end

        it { is_expected.to have_http_status :unprocessable_entity }

        it 'is expected to respond with an error message' do
          expect(response_json['message']).to eq "Instructions can't be blank"
        end
      end
    end
  end

  describe 'as anonymous user' do
    before do
      post '/api/recipes', params: {
        recipe: {
          name: 'Pasta Carbonara',
          instructions: 'Mix and shake it',
          ingredients_attributes: [
            { ingredient_id: rice.id, unit: 'gram', amount: '2000' }
          ]
        }
      }, headers: nil
    end

    it { is_expected.to have_http_status :unauthorized }

    it 'is expected to respond with an error message' do
      expect(response_json['errors'].first).to eq 'You need to sign in or sign up before continuing.'
    end
  end
end
