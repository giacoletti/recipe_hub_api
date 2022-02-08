RSpec.describe 'POST /api/auth', type: :request do
  subject { response }
  describe 'successful registration' do
    before do
      post '/api/auth',
        params: {
          name: 'John Skoglund',
          email: 'johnskoglund@mail.com',
          password: 'password',
          password_confirmation: 'password'
        }
    end

    it { is_expected.to have_http_status :ok }
 
    it 'is expected to create new user' do
      expect(response_json['data']['created_at']).to be_truthy
    end
  end

  describe 'with password not matching' do
    before do
      post '/api/auth',
        params: {
          name: 'John Skoglund',
          email: 'johnskoglund@mail.com',
          password: 'password',
          password_confirmation: 'wrongpassword'
        }
    end

    it { is_expected.to have_http_status :unprocessable_entity }

    it 'is expected to respond with error message' do
      expect(response_json['errors']['full_messages']).to eq ["Password confirmation doesn't match Password"]
    end
  end

  describe 'with invalid email' do
    before do
      post '/api/auth',
           params: {
             email: 'this_is_not_an_email',
             password: 'password',
             password_confirmation: 'password'
           }
    end

    it { is_expected.to have_http_status :unprocessable_entity }

    it 'is expected to respond with error message' do
      expect(response_json['errors']['full_messages']).to eq ["Email is not an email"]
    end
  end
end