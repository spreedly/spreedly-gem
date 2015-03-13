
module Spreedly

  module CreationHelper

    def create_card_on(environment, options = {})
      deets = default_card_deets.merge(options)
      environment.add_credit_card(deets).payment_method
    end

    def create_failed_card_on(environment, options = {})
      deets = default_card_deets.merge(number: '4012888888881881').merge(options)
      environment.add_credit_card(deets).payment_method
    end

    def create_offsite_payment_method_on(environment, options = {})
      deets = default_offsite_payment_method.merge(options)
      environment.add_offsite_method(deets).payment_method
    end


    private
    def default_card_deets
      {
        email: 'perrin@wot.com', number: '5555555555554444', month: 1, year: 2019,
        last_name: 'Aybara', first_name: 'Perrin', retained: true
      }
    end

    def default_offsite_payment_method
      {
        email: 'me@joey.io', retained: true, payment_method_type: 'sprel'
      }
    end
  end

end
