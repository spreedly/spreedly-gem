require 'mechanize'

module Spreedly
  class Subscriber
    # This method is *strictly* for use when testing, and will
    # probably only work against a test Spreedly site anyhow.
    def subscribe(plan_id)
      agent = WWW::Mechanize.new
      page = agent.get(Spreedly.subscribe_url(id, plan_id))
      page = page.forms.first.submit
      form = page.forms.first
      form['credit_card[first_name]'] = 'Joe'
      form['credit_card[last_name]'] = 'Bob'
      form['subscriber[email]'] = 'joe@example.com'
      form['credit_card[number]'] = '4222222222222'
      form['credit_card[card_type]'] = 'visa'
      form['credit_card[verification_value]'] = '234'
      form['credit_card[month]'] = '1'
      form['credit_card[year]'] = '2024'
      page = form.click_button
      raise "Subscription didn't got through" unless page.title == "Thank you!"
    end
  end
end