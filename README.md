# Spreedly Gem

**This is a fork of the spreedly gem. We had to fork it due to the fact that it doesn't convert array data to xml here: https://github.com/spreedly/spreedly-gem/blob/master/lib/spreedly/environment.rb#L328. This fork has a very specific patch to fix our issue. We hope they will make a fix for us in their gem so we can go back to using it.**

A convenient Ruby wrapper for the Spreedly API.

This is an example Ruby integration with Spreedly. This version is no longer actively updated and will be superseded by a new version in the near future. Feature parity may lag behind, so please use this gem at your own risk.

## Philosophy

* No global configuration of authentication credentials.
* No implicit calls to the Spreedly server.
* Don't be too clever.  The real goal is for this to be a thin and simple layer over the API.  The correlation between an API call and a ruby method should be as clear as possible.
* Avoid the approach of using a proxy that at some point gets filled in with data from the server.
* Avoid self-mutation and prefer value objects.  This isn't ActiveRecord so we won't be doing things like gateway.update_attributes(attributes).
* Don't try to improve the interface of the API by doing cool Ruby things in the gem which fix or hide icky parts of the API.  Instead, improve the underlying API to reflect the improvements and then adjust the gem to use the improved underlying API.
* Limit the number of dependencies on other gems to make it as easy possible to incorporate the gem into any project.  Resist the temptation to use the goodness in gems like ActiveSupport or ActiveModel.


## Installation

If you're using bundler, add the gem to your Gemfile:

    gem 'spreedly'

Otherwise gem install:

    $ gem install spreedly


## Usage

#### Basic purchase

Let's start with a simple purchase when you already have a gateway token and a payment method token:

``` ruby
env = Spreedly::Environment.new(environment_key, access_secret)

transaction = env.purchase_on_gateway(gateway_token, payment_method_token, 4432)

transaction.succeeded?    # => true
transaction.token         # => "aGJlY5srn7TFeYKxO5pmwi3CyJd"
```

The amount specified in that example was 4432.  Amounts are always in cents so in this case, we're charging $44.32.

#### Add a gateway
What if you don't have a gateway token yet?  It's pretty easy to add a test gateway:

``` ruby
gateway = env.add_gateway(:test)
gateway.token     # => "DnbEJaaY2egcVkCvg3s8qT38xgt"
```


#### Add a payment method
Need a payment method token to try things out?  With Spreedly it's pretty straightforward to use a
[transparent redirect](https://docs.spreedly.com/guides/adding-payment-methods/web-form/) to give you a
payment method token.  A payment form in your application could look something like this:

``` html
<form action="<%= env.transparent_redirect_form_action %>" method="POST">
  <fieldset>
    <input name="redirect_url" type="hidden" value="http://yourdomain.com/transparent_redirect_done" />
    <input name="environment_key" type="hidden" value="<%= env.key %>" />
    <label for="credit_card_full_name">Name</label>
    <input id="credit_card_full_name" name="credit_card[full_name]" type="text" />

    <label for="credit_card_number">Card Number</label>
    <input id="credit_card_number" name="credit_card[number]" type="text" />

    <label for="credit_card_verification_value">Security Code</label>
    <input id="credit_card_verification_value" name="credit_card[verification_value]" type="text" />

    <label for="credit_card_month">Expires on</label>
    <input id="credit_card_month" name="credit_card[month]" type="text" />
    <input id="credit_card_year" name="credit_card[year]" type="text" />

    <button type='submit'>Submit Payment</button>
  </fieldset>
</form>
```

Notice that we can ask the environment for the form action url and that the environment knows its key to use in the hidden field.

Once Spreedly has recorded the information, it will redirect the browser to the url specified in the `redirect_url` field, tacking on a token that represents the credit card your customer entered. This is the payment_method token you're looking for. In this case your customer would be sent to this url:

    http://yourdomain.com/transparent_redirect_done?token=OEj2G2QJZM4C10AfTLYTrsKIsZH

Once you have the payment method token (OEj2G2QJZM4C10AfTLYTrsKIsZH in this case), you can remember it and use it whenever you'd like.  These [test cards](https://docs.spreedly.com/reference/test-data/) will help.

#### Retrieve a payment method
Let's say you'd like some additional information about the payment method.  You can find a payment method like so:

``` ruby
credit_card = env.find_payment_method(token)
credit_card.last_name      # => "Jones"
credit_card.valid?         # => false

credit_card.errors
# Returns => [
#      { attribute: "first_name", key: "errors.blank", message: "First name can't be blank" },
#      { attribute: "year", key: "errors.expired", message: "Year is expired" },
#      { attribute: "year", key: "errors.invalid", message: "Year is invalid" },
#      { attribute: "number", key: "errors.blank", message: "Number can't be blank" }
#    ]
```

#### Authorize and Capture

``` ruby
auth_transaction = env.authorize_on_gateway(gateway_token, payment_method_token, 250)

if auth_transaction.succeeded?
  capture_transaction = env.capture_transaction(auth_transaction.token)
end
```

You can also specify an optional amount to capture.

``` ruby
capture_transaction = env.capture_transaction(auth_transaction.token, amount: 100)
```

#### Verify

Verify a card is legitimate so you can charge it at a later date.

``` ruby
env.verify_on_gateway(gateway_token, payment_method_token, retain_on_success: true)
```

#### Void and refund

``` ruby
transaction = env.void_transaction(transaction_token)

# Refund the entire amount
transaction = env.refund_transaction(transaction_token)

# Specify an amount to be refunded
transaction = env.refund_transaction(transaction_token, amount: 104)
```

#### Retain and redact

``` ruby
transaction = env.retain_payment_method(payment_method_token)

transaction = env.redact_payment_method(payment_method_token)
```

#### Redact a gateway

``` ruby
transaction = env.redact_gateway(gateway_token)
```


#### Currencies
When you instantiate an environment, you can specify a default currency code like so:

``` ruby
env = Spreedly::Environment.new(environment_key, access_secret, currency_code: 'EUR')
```

If you don't specify a default currency code, we default to 'USD'.  Calls requiring a currency code by default use the environment's currency code.  And of course, you can always override it for a particular call like so:

``` ruby
env.purchase_on_gateway(gateway_token, payment_method_token, amount, currency_code: "GBP")
```


#### Extra options for the basic operations
For Purchase, Authorize, Capture, Refund, Verify, and Void calls, you can specify additional options:

``` ruby
env.purchase_on_gateway(gateway_token, payment_method_token, amount,
                        order_id: "123",
                        description: "The Description",
                        ip: "192.31.123.112",
                        merchant_name_descriptor: "SuperDuper Corp",
                        merchant_location_descriptor: "http://super.com"
                       )
```

#### Complete a transaction (3DS 2)

```ruby
env.complete_transaction(transaction_token)
```

#### Retain on success
Retain a payment method automatically if the purchase, verify, or authorize transaction succeeded.  Saves you a separate call to retain:

``` ruby
env.purchase_on_gateway(gateway_token, payment_method_token, amount, retain_on_success: true)
```

``` ruby
env.verify_on_gateway(gateway_token, payment_method_token, retain_on_success: true)
```

#### Retrieving gateways

``` ruby
gateways = env.list_gateways

# Iterate over the next chunk
next_set = env.list_gateways(gateways.last.token)
```

#### Retrieving payment methods

``` ruby
payment_methods = env.list_payment_methods

# Iterate over the next chunk
next_set = env.list_payment_methods(payment_methods.last.token)
```

#### Retrieving transactions

``` ruby
transactions = env.list_transactions

# Iterate over the next chunk
next_set = env.list_transactions(transactions.last.token)
```

#### Retrieving transactions for a payment method

``` ruby
transactions = env.list_transactions(nil, payment_method_token)

# Iterate over the next chunk
next_set = env.list_transactions(transactions.last.token, payment_method_token)
```

#### Retrieving one gateway

``` ruby
gateway = env.find_gateway(token)
gateway.gateway_type      # => 'paypal'
```

#### Retrieving one transaction

``` ruby
transaction = env.find_transaction(token)
transaction.order_id      # => '30-9904-31114'
```

#### Retrieving the transcript for a transaction

``` ruby
env.find_transcript(transaction_token)
```

#### Updating a credit card

``` ruby
env.update_credit_card(credit_card_token, first_name: 'JimBob', last_name: 'Jones')
```

#### Adding other types of gateways

``` ruby
gateway = env.add_gateway(:paypal, mode: 'delegate', email: 'fred@example.com')
gateway.token     # => "2nQEJaaY3egcVkCvg2s9qT37xrb"
```

#### Adding credit cards

The primary mechanism to add a credit card is to use the transparent redirect payment form. This allows all of the sensitive information to be captured without ever touching your servers.

There are times though when you may want to add a credit card in a more "manual" fashion with an API call.

PLEASE NOTE: Using this API call can significantly increase your PCI compliance requirements.

Here's how you can do it:

``` ruby
options = {
email: 'perrin@wot.com', number: '5555555555554444', month: 1, year: 2023, last_name: 'Aybara', first_name: 'Perrin', data: "occupation: Blacksmith"
}
transaction = env.add_credit_card(options)

transaction.token                 # => "2nQEJaaY3egcVkCvg2s9qT37xrb"
transaction.payment_method.token            # => "7rbEKaaY0egcBkCrg2sbqTo7Qrb"
transaction.payment_method.last_name        # => "Aybara"
```

You can also retain the card immediately like so:

``` ruby
options = {
email: 'perrin@wot.com', number: '5555555555554444', month: 1, year: 2023, last_name: 'Aybara', first_name: 'Perrin', data: "occupation: Blacksmith", retained: true
}
transaction = env.add_credit_card(options)

transaction.payment_method.storage_state    # => "retained"
```

And you might want to specify a number of other details like the billing address, etc:

``` ruby
options = {
email: 'leavenworth@free.com', number: '9555555555554444', month: 3, year: 2021, last_name: 'Smedry', first_name: 'Leavenworth', data: "talent: Late", address1: '10 Dragon Lane', address2: 'Suite 9', city: 'Tuki Tuki', state: 'Mokia', zip: '1122', country: 'Free Kingdoms', phone_number: '81Ab', retained: true
}

transaction = env.add_credit_card(options)

transaction.payment_method.last_name      # => "Smedry"

```

#### Getting meta information about the supported gateways

You can get the full list of supported gateways like so:

``` ruby
env.gateway_options
```

#### Getting meta information about the supported payment method distribution receivers

You can get the full list of supported receivers like so:

``` ruby
env.receiver_options
```

#### Delivering a payment method

You can deliver a payment method to a third party using [Payment Method Distribution](https://docs.spreedly.com/guides/payment-method-distribution/). Once a receiver is set up and you have a payment method that you would like to share, you can use the following call:

```ruby
env.deliver_to_receiver(
  "receiver token goes here",
  "payment method token goes here",
  headers: { "Content-Type": "application/json" },
  url: "https://spreedly-echo.herokuapp.com",
  body: { card_number: "{{credit_card_number}}" }.to_json
)
```

## Error Handling

When you make a call to the API, there are times when things don't go as expected.  For the most part, when a call is made, a Transaction is created behind the scenes at Spreedly.  In general,
you can inquire whether that transaction succeeded? or not and get it's message.  There are times when a Transaction cannot be created, and in general, an exception is raised for these cases.

You can be as specific as you'd like in handling these exceptions or, you could simply rescue Spreedly::Error to handle all of them.

#### Declined purchase

``` ruby
transaction = env.purchase_on_gateway(gateway_token, payment_method_token, 4432)

transaction.succeeded?  # => false
transaction.message     # => "Unable to process the purchase transaction."
```

#### Invalid payment method

``` ruby
transaction = env.purchase_on_gateway(gateway_token, payment_method_token, 4432)

transaction.succeeded?  # => false
transaction.message     # => "The payment method is invalid."

transaction.payment_method.errors
transaction.payment_method.errors
# Returns => [
#      { attribute: "last_name", key: "errors.blank", message: "Last name can't be blank" },
#      { attribute: "number", key: "errors.blank", message: "Number can't be blank" }
#    ]

```

#### Failure to find

``` ruby
env.find_transaction("Some Unknown Token")  # raises a Spreedly::NotFoundError
```

#### Invalid environment credentials

``` ruby
env = Spreedly::Environment.new(environment_key, "some bogus secret")
env.purchase_on_gateway(gateway_token, payment_method_token, 4432) # Raises Spreedly::AuthenticationError
```

#### Unknown payment method trying to make a purchase

``` ruby
env.purchase_on_gateway(gateway_token, "Some Unknown Token", 4432) # Raises Spreedly::TransactionCreationError
```

#### Trying to use a non-test gateway or a non-test payment method with an inactive account

You're free to use [test card data](https://docs.spreedly.com/reference/test-data/) and a [Test gateway](https://docs.spreedly.com/payment-gateways/test/) to integrate Spreedly without having a
paid Spreedly account.  If you try to use a real card or a real gateway when your account isn't yet paid for, we'll raise an exception:

``` ruby
env.purchase_on_gateway(gateway_token, "Payment Method Token for a real card", 4432) # Raises Spreedly::PaymentRequiredError
```

#### Timeout errors

If Spreedly is not responding, we'll raise an exception.  Spreedly itself has a timeout so that if a gateway isn't responding, it'll reflect that in the response.  The gem has its own timeout to
handle the case of Spreedly itself not responding.  Here's an example:

``` ruby
env.purchase_on_gateway(gateway_token, payment_method_token, 802) # Raises Spreedly::TimeoutError
```

For api calls that actually talk to a payment gateway, the timout is longer since some gateways can take longer to respond when under load.

## Sample applications using the gem

There are some sample applications with source code using this gem.  You can [find them here](https://docs.spreedly.com/resources/apps-libs/).

## Contributing

We're happy to consider [pull requests](https://help.github.com/articles/using-pull-requests).

There are two rake tasks to help run the tests:

```
rake test:remote  # Run remote tests that actually hit the Spreedly site
rake test:units   # Run unit tests
```

To run remote tests you'll need to copy `test/credentials/credentials.yml.example` to `test/credentials/credentials.yml` and update the values of `environment_key` and `access_secret`.

When you're happy with your change, don't forget to add your contributions to CHANGELOG.md. We follow the changelog format found [here](https://keepachangelog.com/en/1.0.0/).
