# Changelog

All notable changes to this project will be documented in this file.

## [2.0.25] - 2020-10-08
### Added
- @hoenth - Add list_receivers
- @hoenth - Add list_supported_receivers

## [2.0.24] - 2019-08-21
### Added
- @jeremywrowe - Add 3D Secure 2 complete transaction

## [2.0.23] - 2019-08-16
### Added
- @bayprogrammer - Add 3D Secure 2 third-party auth abilities to gateway class

## [2.0.22] - 2019-08-14
### Added
- @jeremywrowe - Support for three_ds_version, three_ds_context, and channel on
  authorization / purchase

## [2.0.21] - 2019-07-19
### Added
- @jeremywrowe - Support for Stored Credentials on authorization / purchase
- @jeremywrowe - 3D Secure 2 abilities to gateway class

## [2.0.20] - 2019-06-27
### Changed
- @patrickarnett - Modify `list_transactions` and `list_transactions_url` to take `count`, `order`, and `state` arguments in an optional hash.

## [2.0.19] - 2019-06-07
### Added
- Lori Holden - Receiver redaction
- Lancelot Carlson - Recached payment method support
- @pawel-krysiak and @jeremywrowe - Support 3D-Secure transactions

### Changed
- @therufs - Expose `display_api_url` on gateway
- @ZeusPerez - Expose `continue_caching` on transactions
- @adamcohen - Expose `transaction_type` on transaction
- @adamcohen - Expose `gateway_specific_response_fields` on transaction
- @adamcohen - Expose `payment_method_type` on transaction

## [2.0.16]
- Support disburse [rwdaigle]
- Support full_name property [maccca]
- Add support for purchase shipping address override [davidsantoso]
- Allow email override in transactions [duff]
- Add options for store_on_gateway [fedesoria]
- Support fingerprint [duff]

## 2.0.15
- Add support for supports_fraud_review gateway characteristic [markabe]
- Add support for the store API call [duff]
- Add support for company name property on credit card [duff]
- Deliver payment method uses talking to gateway timeout [duff]
- Fix issue creating production receiver [duff]

## 2.0.14
- Add support for gateway_specific_fields [duff]

## 2.0.13
- Check attributes for non-nil before sending [markabe]
- Add supports_verify option to Gateway [duff]
- Add support for verify_on_gateway API call [duff]
- Add support for RecacheSensitiveData transaction [duff]
- Remove cacert.pem and rely on system certs [duff]
- Adds add_receiver method to environment [Thomas Hoen]
- Adds deliver_receiver functionality [Thomas Hoen]
- Add support for first_six_digits [duff]
- Add support for supports_general_credit characteristic [markabe]

## 2.0.12
- Add support for new credit card field: eligible_for_card_updater [markabe]

## 2.0.11
- Add support for ThirdPartyTokens [duff]

## 2.0.10
- Add support for gateway_transaction_id [hoenth]

## 2.0.9
- Improve support for base_url around ssl [duff]

## 2.0.8
- Add support for gateway regions [duff]

## 2.0.7
- Add support for company_name to gateway options [duff]
- Implemented gateway characteristics [ilyutov]
- Allow access to gateway options w/o credentials [duff]

## 2.0.6
- Add auth_mode support to gateway options call [sosedoff]
- Pass through verification_value when creating a card directly [duff]

## 2.0.5
- Add ability to retrieve a transcript [hoenth]

## 2.0.3
- Readme improvements
- Smarter about timeouts - now only have long timeout for calls
  that actually talk to a payment gateway.  The other calls can
  have shorter timeouts.

## 2.0.2
- Add support for gateway options call.

## 2.0.1
- List the transactions for a payment method
- Allow adding other gateways
- Listing Payment Methods (retained on an account)
- Updating a Payment Method
- Listing Your Gateways
- Finding a Gateway
- Fix Ruby 1.9.2 private method issue
- Add ability to find a bank account payment method
- Add ability to redact a gateway

## 2.0.0
- This gem is now intended for the Spreedly API.  For the Spreedly
  Subscriptions API, you can use the spreedly_subscriptions gem
  which has everything that 1.4.0 had.

## 1.4.0
- Add accessor for invoices
- Add accessor for last successful invoice

## 1.3.6
- Modernize packaging
- Improve handling of bad credentials

## 1.3.5
- Move to Spreedly repo.

## 1.3.4
- Add result body to comp validation failure. [ntalbott]

## 1.3.3
- Add support for return_url in Spreedly.edit_subscriber_url [jjthrash]
- Add support for return_url in Spreedly.subscribe_url [jjthrash]

## 1.3.2
- Added methods on subscriber: update, allow_free_trial,
  add_fee [mateuszzawisza]
- Fixing tests: generate spreedly url and edit url working with all
  site names [mateuszzawisza]
- Add support for pre-population of the subscribe page via the subscribe
  url. [davemcp]

## 1.3.1
- Handle new error reporting when creating a subscriber.
- Use a more sane way of setting attributes in the mock, and make plans have a
  plan type [seancribbs].
- Allow optional arguments to be passed when creating subscribers [jaknowlden].

## 1.3.0 / 2009-06-04
- Properly handle invalid Subscriber lookup [karnowski].
- Added support for stopping auto renew [scottmotte, dsimard].

## 1.2.2 / 2009-05-11
- Fixed an error in the README [karnowski].

## 1.2.1 / 2009-04-30
- A few documentation tweaks.

## 1.2.0 / 2009-04-30
- Added mock support for Subscriber#activate_free_trial [scottmotte].
- Added tests for Subscriber#activate_free_trial.

## 1.1.0 / 2009-04-24
- Compatibility with the latest hoe and HTTParty [seancribbs].
- Added Subscriber.delete! [scottmotte].
- Added Subscriber#activate_free_trial [scottmotte].

## 1.0.0 / 2009-03-17
- Initial release.

