# Fuser

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fuser'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fuser

## Usage

Add api to Fuser config:


    # config/initializers
    Fuser.configure do |config|
      config.api_key = <your_firebase_app_api_key>
    end


# Basic Usage

    Fuser.<action>(<action_params_hash>)

    => #<Fuser::Response:0x000056231221eb08 @response=#<Net::HTTPOK 200 OK readbody=true>, @action=<action_name>>


# Example

Sign Up with emain/password:


    firebase_response = Fuser.sign_up(email: 'email@example.com', password: 'password')

    => #<Fuser::Response:0x000056231221eb08 @response=#<Net::HTTPOK 200 OK readbody=true>, @action=:sign_up>

    firebase_response.body

    {
      "kind" =>
    "identitytoolkit#SignupNewUserResponse",
      "idToken" => "eyJhbGciOiJSUzI1NiIsImtpZCI6IjBhZDdkNTY3ZWQ3M2M2NTEzZWQ0ZTE0ZTc4OGRjZWU4NjZlMzY3ZDMiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vZnVzZXItdGVzdCIsImF1ZCI6ImZ1c2VyLXRlc3QiLCJhdXRoX3RpbWUiOjE1NTI1NzgwMzUsInVzZXJfaWQiOiJIWjVKR0t5MlVYYlk5Nk9VMTdseFBQZXdiUHExIiwic3ViIjoiSFo1SkdLeTJVWGJZOTZPVTE3bHhQUGV3YlBxMSIsImlhdCI6MTU1MjU3ODAzNSwiZXhwIjoxNTUyNTgxNjM1LCJlbWFpbCI6ImRlZW1hazEzQHJhbWJsZXIucnUiLCJlbWFpbF92ZXJpZmllZCI6ZmFsc2UsImZpcmViYXNlIjp7ImlkZW50aXRpZXMiOnsiZW1haWwiOlsiZGVlbWFrMTNAcmFtYmxlci5ydSJdfSwic2lnbl9pbl9wcm92aWRlciI6InBhc3N3b3JkIn19.tY8vf2tDfzInbsTAA01GkJmwAwIOfLdqv25BR4ag9eGgR5mo2J9FR9qNRTfoclWiFBl0qlh1bq_XkYYWixkr4zasEhzJwvYBuUYJ1Q3I0R9VHEIB2FudQGRvQhLr8ZbTzGu4E-Q_6BP9zP27pBvGbYDBQmy23TkWXLUKTA_drOrwB-vSwkeFDqf2hmhct9tbDzy8a3G764oPBPgANjkTUVHMtGz-gPoZQ8GZQG9MtAJu4dh01oM6jJtole-0DfQydoTZfvCPuTlHtUa0TOqzn6mZ51pS2XzCEct15TJabpKkRbHHJUSDQRpxQtWPfdeluwbKrshm-RvAqxsXPj2IAg",
      "email" => "deemak13@rambler.ru",
      "refreshToken" => "AEu4IL1UAqJCMvidiR0v62n6Ajf6JqJrpc2GvemoQ1Ip-HC-JzjIWZ_qslYF6p_vMOjcy6jbALuz7Bpj3RkH0qa5tUZZ7crex3F8a-7r9aDH62gGBPilC20d4luieSHKTX14e_naquuJtBoNjuk6r9F4KLVgs1Ay-AtuWSwCN4pC318uZW_9tuictUpnFuJJMFgdJtFYDzAo",
      "expiresIn"=>"3600",
      "localId"=>"HZ5JGKy2UXbY96OU17lxPPewbPq1"
    }

    firebase_response.success?

    => true



Actions List:


Action (method)             | Params
--------------------------- | ----------------
verify_token                | `token` - A Firebase Auth custom token from which to create an ID and refresh token pair.
refreshToken                | `token` - A Firebase Auth refresh token.
sign_up, sign_in            | `email` - The email for the user sign in / sign up.<br>`password` - The password for the user to sign in / sign up
anonymous_sign_in           | sign in a user anonymously, no params needed
reset_password              | `email` - User's email address.
verify_reset_password       | `oob_code` - The email action code sent to the user's email for resetting the password.
confirm_reset_password      | `email` - User's email address.<br>`oob_code` - The email action code sent to the user's email for resetting the password.
set_account_info            | `token` - A Firebase Auth ID token for the user.<br>`email` - user's new email.<br>`password` - user's new password<br>`display_name` - user's new display name.<br>`photo_url` - user's new photo url<br>`delete_attributes` - List of attributes to delete, "DISPLAY_NAME" or "PHOTO_URL". This will nullify these values.
get_account_info            | `token` - A Firebase Auth ID token of the user.
oauth_sign_in               | `access_token` - For login with OAuth Access Token<br>`id_token` - For login with OAuth ID Token<br>`oauth_token_secret` - OAuth Token Secret (for Twitter)<br>`provider_id` - OAuth provider (`facebook.com`, `google.com` or `twitter.com`)<br>`request_uri` - The URI to which the IDP redirects the user back.
oauth_link                  | `token` - A Firebase Auth ID toke of the user to link<br>`access_token` - For login with OAuth Access Token<br>`id_token` - For login with OAuth ID Token<br>`oauth_token_secret` - OAuth Token Secret (for Twitter)<br>`provider_id` - OAuth provider (`facebook.com`, `google.com` or `twitter.com`)<br>`request_uri` - The URI to which the IDP redirects the user back.
unlink_provider             | `token` - A Firebase Auth ID toke of the user to unlink<br>`providers` - The list of provider IDs to unlink, eg: 'google.com', 'password', etc.
send_email_verification     | `token` - A Firebase Auth ID toke of the user to unlink
confirm_email_verification  | `oob_code` - The action code sent to user's email for email verification.
delete_account              | `token` - A Firebase Auth ID toke of the user to unlink

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/fuser. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Fuser project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/fuser/blob/master/CODE_OF_CONDUCT.md).
