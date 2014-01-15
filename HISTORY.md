# Changelog

## 2.0.7
* Add support for company_name to gateway options [duff]
* Implemented gateway characteristics [ilyutov]
* Allow access to gateway options w/o credentials [duff]

## 2.0.6
* Add auth_mode support to gateway options call [sosedoff]
* Pass through verification_value when creating a card directly [duff]

## 2.0.5
* Add ability to retrieve a transcript [hoenth]

## 2.0.3
* Readme improvements
* Smarter about timeouts - now only have long timeout for calls
  that actually talk to a payment gateway.  The other calls can
  have shorter timeouts.

## 2.0.2
* Add support for gateway options call.

## 2.0.1
* List the transactions for a payment method
* Allow adding other gateways
* Listing Payment Methods (retained on an account)
* Updating a Payment Method
* Listing Your Gateways
* Finding a Gateway
* Fix Ruby 1.9.2 private method issue
* Add ability to find a bank account payment method
* Add ability to redact a gateway

## 2.0.0
* This gem is now intended for the Spreedly API.  For the Spreedly
  Subscriptions API, you can use the spreedly_subscriptions gem
  which has everything that 1.4.0 had.

## 1.4.0

* Add accessor for invoices
* Add accessor for last successful invoice

## 1.3.6

* Modernize packaging
* Improve handling of bad credentials

## 1.3.5

* Move to Spreedly repo.

## 1.3.4

* Add result body to comp validation failure. [ntalbott]

## 1.3.3

* Add support for return_url in Spreedly.edit_subscriber_url [jjthrash]
* Add support for return_url in Spreedly.subscribe_url [jjthrash]

## 1.3.2

* Added methods on subscriber: update, allow_free_trial,
  add_fee [mateuszzawisza]
* Fixing tests: generate spreedly url and edit url working with all
  site names [mateuszzawisza]
* Add support for pre-population of the subscribe page via the subscribe
  url. [davemcp]

## 1.3.1

* Handle new error reporting when creating a subscriber.
* Use a more sane way of setting attributes in the mock, and make plans have a
  plan type [seancribbs].
* Allow optional arguments to be passed when creating subscribers [jaknowlden].

## 1.3.0 / 2009-06-04

* Properly handle invalid Subscriber lookup [karnowski].
* Added support for stopping auto renew [scottmotte, dsimard].

## 1.2.2 / 2009-05-11

* Fixed an error in the README [karnowski].

## 1.2.1 / 2009-04-30

* A few documentation tweaks.

## 1.2.0 / 2009-04-30

* Added mock support for Subscriber#activate_free_trial [scottmotte].
* Added tests for Subscriber#activate_free_trial.

## 1.1.0 / 2009-04-24

* Compatibility with the latest hoe and HTTParty [seancribbs].
* Added Subscriber.delete! [scottmotte].
* Added Subscriber#activate_free_trial [scottmotte].

## 1.0.0 / 2009-03-17

* Initial release.

