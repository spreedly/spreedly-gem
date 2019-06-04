# Changelog

All notable changes to this project will be documented in this file.

## [Unreleased]
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
