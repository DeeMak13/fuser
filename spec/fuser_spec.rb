require 'webmock/rspec'

RSpec.describe Fuser do
  it 'has a version number' do
    expect(Fuser::VERSION).not_to be nil
  end

  describe 'api calls' do
    let(:token) { 'token' }
    let(:email) { 'user@example.com' }
    let(:password) { 'password' }
    let(:new_password) { 'new_password' }
    let(:oob_code) { 'oobCode' }
    let(:fuser_params) do
      {
        token: 'token',
        email: 'user@example.com',
        password: 'password',
        new_password: 'new_password',
        oob_code: 'oobCode',
        display_name: 'Cool Dude',
        request_uri: 'http://localhost:3000',
        access_token: 'oauth_access_token',
        provider_id: 'facebook.com',
        providers: ['facebook.com', 'password'],
      }
    end

    before do
      allow(described_class).to receive_message_chain(:configuration, :api_key).and_return('api_key')
    end

    I18n.t('fuser.endpoints').keys.each do |action|
      describe ".#{action}" do
        subject { described_class.public_send(action, fuser_params) }

        context 'valid request' do
          let!(:request) do
            stub_request(:post, Fuser::Endpoint.for(action))
              .with(
                body: kind_of(String),
                headers: { 'Content-Type': 'application/json' }
              ).to_return(
                status: 200, body: {}.to_json, headers: {}
              )
          end

          it 'does not raise error' do
            expect { subject }.not_to raise_error
            expect(request).to have_been_requested
          end
        end

        context 'invalid request' do
          let!(:request) do
            stub_request(:post, Fuser::Endpoint.for(action))
              .with(
                body: kind_of(String),
                headers: { 'Content-Type': 'application/json' }
              ).to_return(
                status: 400, body: { error: { code: 400, message: 'OPERATION_NOT_ALLOWED' } }.to_json, headers: {}
              )
          end

          it 'returns error response' do
            subject
            expect(request).to have_been_requested
          end
        end
      end
    end
  end
end
