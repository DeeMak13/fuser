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
    let(:new_email) { 'new_user@example.com' }
    let(:oob_code) { 'oobCode' }
    let(:action_arguments) do
      {
        verify_token: { token: token },
        refresh_token: { token: token },
        sign_up: { email: email, password: password },
        sign_in: { email: email, password: password },
        anonymous_sign_in: nil,
        reset_password: { email: email },
        verify_reset_password: { oob_code: oob_code },
        confirm_reset_password: { new_password: new_password, oob_code: oob_code },
        change_email: { token: token, new_email: new_email },
        change_password: { token: token, new_password: new_password }
      }
    end

    before do
      allow(described_class).to receive_message_chain(:configuration, :api_key).and_return('api_key')
    end

    I18n.t('fuser.endpoints').keys.each do |action|
      describe ".#{action}" do
        subject { described_class.public_send(action, arguments) }
        let(:arguments) { action_arguments[action] }

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
