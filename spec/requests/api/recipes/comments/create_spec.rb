RSpec.describe 'POST /api/recipes/:id/comments', type: :request do
  subject { response }

  let(:user) { create(:user) }
  let(:credentials) { user.create_new_auth_token }
  let!(:recipe) { create(:recipe) }

  describe 'As an authenticated user' do
    describe 'successfully' do
      before do
        post "/api/recipes/#{recipe.id}/comments",
             params: { comment: { body: 'Awesome recipe' } }, headers: credentials
        @comment = Comment.last
      end

      it { is_expected.to have_http_status :created }

      it 'is expected to create an instance of a comment' do
        expect(@comment).to_not eq nil
      end

      it 'is expected to save a comment in database' do
        expect(@comment.body).to eq 'Awesome recipe'
      end

      it 'is expected to respond with the saved comment' do
        expect(response_json['comment']['body']).to eq 'Awesome recipe'
      end
    end

    describe 'unsuccessfully' do
      describe 'due to invalid recipe id' do
        before do
          post '/api/recipes/pinaples/comments',
               params: { comment: { body: 'Awesome recipe' } }, headers: credentials
        end

        it { is_expected.to have_http_status :not_found }

        it 'is expected to respond with an error message' do
          expect(response_json['message']).to eq 'Recipe not found'
        end
      end

      describe 'due to missing params' do
        before do
          post "/api/recipes/#{recipe.id}/comments",
               params: {}, headers: credentials
        end

        it { is_expected.to have_http_status :unprocessable_entity }

        it 'is expected to respond with an error message' do
          expect(response_json['message']).to eq 'Comment is missing'
        end
      end

      describe 'due to missing comment body' do
        before do
          post "/api/recipes/#{recipe.id}/comments",
               params: { comment: { body: '' } }, headers: credentials
        end

        it { is_expected.to have_http_status :unprocessable_entity }

        it 'is expected to respond with an error message' do
          expect(response_json['message']).to eq "Body can't be blank"
        end
      end
    end
  end
end
