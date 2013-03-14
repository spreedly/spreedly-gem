require 'mechanize'

module Spreedly
  class Subscriber
    # This method is *strictly* for use when testing, and will
    # probably only work against a test Spreedly site anyhow.
    def subscribe(plan_id, card_number="4222222222222")
      agent = Mechanize.new
      page = agent.get(Spreedly.subscribe_url(id, plan_id))
      page = page.forms.first.submit
      form = page.forms.first
      form['credit_card[first_name]'] = 'Joe'
      form['credit_card[last_name]'] = 'Bob'
      form['subscriber[email]'] = 'joe@example.com'
      form['credit_card[number]'] = card_number
      form['credit_card[card_type]'] = 'visa'
      form['credit_card[verification_value]'] = '234'
      form['credit_card[month]'] = '1'
      form['credit_card[year]'] = '2024'
      page = form.click_button

      if card_number == "4222222222222"
        raise "Subscription didn't go through" unless page.title == "Thank you!"
      end
    end
  end
end
