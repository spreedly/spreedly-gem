# Spreedly Gem

A convenient Ruby wrapper for the Spreedly API.

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

#### Create a gateway
What if you don't have a gateway token yet?  It's pretty easy to create a test gateway:

``` ruby
gateway = env.create_gateway(:test)
gateway.token     # => "DnbEJaaY2egcVkCvg3s8qT38xgt"
```


#### Create a payment method
Need a payment method token to try things out?  With Spreedly it's pretty straightforward to use a
[transparent redirect](https://core.spreedly.com/manual/quickstart#submit-payment-form) to give you a
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

Once you have the payment method token (OEj2G2QJZM4C10AfTLYTrsKIsZH in this case), you can remember it and use it whenever you'd like.  These [test cards](https://core.spreedly.com/manual/test-data) will help.

#### Retrieve a payment method
Let's say you'd like some additional information about the payment method.  You can do so like this:

``` ruby
credit_card = env.find_payment_method(token)
credit_card.last_name      # => "Jones"
credit_card.valid?         # => false

credit_card.errors
# Returns => {
#    last_name: { key: "errors.blank", text: "Last name can't be blank" },
#    year: { key: "errors.invalid", text: "Year is invalid" }
# }
```

#### Authorize and Capture

``` ruby
auth_transaction = env.authorize_on_gateway(gateway_token, payment_method_token, 250)

if auth_transaction.succeeded?
  capture_transaction = env.capture_on_gateway(gateway_token, auth_transaction.token)
end
```

#### Void and refund

``` ruby
transaction = env.void_transaction(transaction_token)

# Refund the entire amount
transaction = env.refund_transaction(transaction_token)

# Specify an amount to be refunded
transaction = env.refund_transaction(transaction_token, 104)
```

#### Retain and redact

``` ruby
transaction = env.retain_payment_method(payment_method_token)

transaction = env.redact_payment_method(payment_method_token)
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
For Purchase, Authorize, Capture, Credit, and Void calls, you can specify additional options:

``` ruby
env.purchase_on_gateway(gateway_token, payment_method_token, amount,
                        order_id: "123",
                        description: "The Description",
                        ip: "192.31.123.112",
                        currency_code: "GBP",
                        merchant_name_descriptor: "SuperDuper Corp",
                        merchant_location_descriptor: "http://super.com"
                       )
```

#### Retain on success
Retain a payment method automatically if the purchase or authorize transaction succeeded.  Saves you a separate call to retain:

``` ruby
env.purchase_on_gateway(gateway_token, payment_method_token, amount, retain_on_success: true)
```

#### Retrieving gateways

``` ruby
gateways = env.find_gateways

# Iterate over the next chunk
next_set = env.find_gateways(gateways.last.token)
```

#### Retrieving payment methods

``` ruby
payment_methods = env.find_payment_methods

# Iterate over the next chunk
next_set = env.find_payment_methods(payment_methods.last.token)
```

#### Retrieving transactions

``` ruby
transactions = env.find_transactions

# Iterate over the next chunk
next_set = env.find_transactions(transactions.last.token)
```

#### Retrieving transactions for a payment method

``` ruby
transactions = env.find_transactions(nil, payment_method_token)

# Iterate over the next chunk
next_set = env.find_transactions(transactions.last.token, payment_method_token)
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
env.find_transaction_transcript(transaction_token)
```

#### Updating a payment method

``` ruby
env.update_payment_method(payment_method_token, first_name: 'JimBob', last_name: 'Jones')
```

#### Creating other types of gateways

``` ruby
gateway = env.create_gateway(:paypal, mode: 'delegate', email: 'fred@example.com')
gateway.token     # => "2nQEJaaY3egcVkCvg2s9qT37xrb"
```

## Error Handling

When you make a call to the API, there are times when things don't go as expected.  This is an area of the docs we're still working on.  We'll be gradually filling
it in with more details as we decide on Exception names, etc.

#### Failure to find

``` ruby
env.find_transaction("Some Unknown Token")  # raises an exception.
```

#### Invalid payment method

``` ruby
transaction = env.purchase_on_gateway(gateway_token, payment_method_token, 4432)

transaction.succeeded?  # => false
transaction.message     # => "The payment method is invalid."

transaction.payment_method.errors
# Returns => {
#    year: { key: "errors.invalid", text: "Year is invalid" },
#    number: { key: "errors.blank", text: "Number can't be blank" }
# }
```

#### Declined purchase

``` ruby
transaction = env.purchase_on_gateway(gateway_token, payment_method_token, 4432)

transaction.succeeded?  # => false
transaction.message     # => "Unable to process the purchase transaction."
```

#### Invalid environment credentials

``` ruby
env = Spreedly::Environment.new(environment_key, "some bogus secret")
env.purchase_on_gateway(gateway_token, payment_method_token, 4432) # Raises exception
```

#### Unknown payment method

``` ruby
env.purchase_on_gateway(gateway_token, "Some Unknown Token", 4432) # Raises exception
```


## Contributing

We're happy to consider [pull requests](https://help.github.com/articles/using-pull-requests).

