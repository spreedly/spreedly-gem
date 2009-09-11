require 'rubygems'
require 'test/unit'
require 'shoulda'
require 'yaml'
require 'pp'

if ENV["SPREEDLY_TEST"] == "REAL"
  require 'spreedly'
  require 'spreedly/test_hacks'
else
  require 'spreedly/mock'
end

test_site = YAML.load(File.read(File.dirname(__FILE__) + '/test_site.yml'))
Spreedly.configure(test_site['name'], test_site['token'])

class SpreedlyGemTest < Test::Unit::TestCase
  def self.only_real
    yield if ENV["SPREEDLY_TEST"] == "REAL"
  end

  context "A Spreedly site" do
    setup do
      Spreedly::Subscriber.wipe!
    end

    should "delete a subscriber" do
      one = create_subscriber
      two = create_subscriber
      subscribers = Spreedly::Subscriber.all
      assert subscribers.size == 2
      Spreedly::Subscriber.delete!(one.id)
      subscribers = Spreedly::Subscriber.all
      assert subscribers.size == 1
      assert_equal two.id, subscribers.first.id
    end

    context "adding a subscriber" do
      should "generate a token" do
        subscriber = Spreedly::Subscriber.create!('joe')
        assert_not_nil subscriber.token
        assert_equal subscriber.token, Spreedly::Subscriber.find('joe').token
      end
    
      should "accept email address as an argument" do
        subscriber = Spreedly::Subscriber.create!('joe', 'a@b.cd')
        assert_equal 'a@b.cd', Spreedly::Subscriber.find('joe').email
      end

      should "accept screen name as an argument" do
        subscriber = Spreedly::Subscriber.create!('joe', 'a@b.cd', 'tuna')
        assert_equal 'tuna', Spreedly::Subscriber.find('joe').screen_name
      end

      should "accept optional arguments: like billing first name" do
        subscriber = Spreedly::Subscriber.create!('joe', {:billing_first_name => 'Joe'})
        assert_equal 'Joe', Spreedly::Subscriber.find('joe').billing_first_name
      end
    end # adding a subscriber
    
    should "get a subscriber" do
      id = create_subscriber.id
      subscriber = Spreedly::Subscriber.find(id)
      assert_nil subscriber.active_until
    end
    
    should "return nil when getting a subscriber that does NOT exist" do
      assert_nil Spreedly::Subscriber.find("junk")
    end
    
    should "expose and parse attributes" do
      subscriber = create_subscriber
      assert_kind_of Time, subscriber.created_at
      assert_equal false, subscriber.active
      assert_equal false, subscriber.recurring
      assert_equal BigDecimal('0.0'), subscriber.store_credit
    end
    
    should "raise error if subscriber exists" do
      create_subscriber('bob')
      ex = assert_raise(RuntimeError) do
        create_subscriber('bob')
      end
      assert_match(/exists/i, ex.message)
    end
    
    should "raise error if subscriber is invalid" do
      ex = assert_raise(RuntimeError) do
        create_subscriber('')
      end
      assert_match(/customer id can't be blank/i, ex.message)
    end
    
    should "create with additional params" do
      subscriber = create_subscriber("fred", "fred@example.com", "FREDDY")
      assert_equal "FREDDY", subscriber.screen_name
      assert_equal "fred@example.com", subscriber.email
    end
    
    should "return all subscribers" do
      one = create_subscriber
      two = create_subscriber
      subscribers = Spreedly::Subscriber.all
      assert subscribers.size >= 2
      assert subscribers.detect{|e| e.id == one.id}
      assert subscribers.detect{|e| e.id == two.id}
    end
    
    should "generate a subscribe url" do
      assert_equal "https://spreedly.com/terralien-test/subscribers/joe/subscribe/1/Joe%20Bob",
        Spreedly.subscribe_url('joe', '1', "Joe Bob")
      assert_equal "https://spreedly.com/terralien-test/subscribers/joe/subscribe/1/",
        Spreedly.subscribe_url('joe', '1')
    end
    
    should "generate an edit subscriber url" do
      assert_equal "https://spreedly.com/terralien-test/subscriber_accounts/zetoken",
        Spreedly.edit_subscriber_url('zetoken')
    end
    
    should "comp an inactive subscriber" do
      sub = create_subscriber
      assert !sub.active?
      assert_nil sub.active_until
      assert_equal "", sub.feature_level
      sub.comp(1, 'days', 'Sweet!')
      sub = Spreedly::Subscriber.find(sub.id)
      assert_not_nil sub.active_until
      assert_equal 'Sweet!', sub.feature_level
      assert sub.active?
    end
    
    should "comp an active subscriber" do
      sub = create_subscriber
      assert !sub.active?
      sub.comp(1, 'days')

      sub = Spreedly::Subscriber.find(sub.id)
      assert sub.active?
      old_active_until = sub.active_until
      sub.comp(1, 'days')

      sub = Spreedly::Subscriber.find(sub.id)
      assert sub.active?
      assert old_active_until < sub.active_until
    end
    
    should "throw an error if comp is against unknown subscriber" do
      sub = create_subscriber
      Spreedly::Subscriber.wipe!
      ex = assert_raise(RuntimeError) do
        sub.comp(1, 'days')
      end
      assert_match(/exists/i, ex.message)
    end
    
    should "throw an error if comp is invalid" do
      sub = create_subscriber
      ex = assert_raise(RuntimeError) do
        sub.comp(nil, nil)
      end
      assert_match(/validation/i, ex.message)
      assert_raise(RuntimeError){sub.comp(1, nil)}
      assert_raise(RuntimeError){sub.comp(nil, 'days')}
    end
    
    should "return subscription plans" do
      assert !Spreedly::SubscriptionPlan.all.empty?
      assert_not_nil Spreedly::SubscriptionPlan.all.first.name
    end
    
    should "return the subscription plan id" do
      plan = Spreedly::SubscriptionPlan.all.first
      assert_not_equal plan.id, plan.object_id
    end
    
    should "be able to find an individual subscription plan" do
      plan = Spreedly::SubscriptionPlan.all.first
      assert_equal plan.name, Spreedly::SubscriptionPlan.find(plan.id).name
    end
    
    context "with a Free Trial plan" do
      setup do
        @trial = Spreedly::SubscriptionPlan.all.detect{|e| e.name == "Test Free Trial Plan" && e.trial?}
        assert @trial, "For this test to pass in REAL mode you must have a trial plan in your Spreedly test site with the name \"Test Free Trial Plan\"."
      end
      
      should "be able to activate free trial" do
        sub = create_subscriber
        assert !sub.active?
        assert !sub.on_trial?
        
        sub.activate_free_trial(@trial.id)
        sub = Spreedly::Subscriber.find(sub.id)
        assert sub.active?
        assert sub.on_trial?
      end
      
      should "throw an error if a second trial is activated" do
        sub = create_subscriber
        sub.activate_free_trial(@trial.id)
        ex = assert_raise(RuntimeError){sub.activate_free_trial(@trial.id)}
        assert_match %r{not eligible}, ex.message
      end
      
      should "throw errors on invalid free trial activation" do
        sub = create_subscriber
        
        ex = assert_raise(RuntimeError){sub.activate_free_trial(0)}
        assert_match %r{no longer exists}, ex.message

        ex = assert_raise(RuntimeError){sub.activate_free_trial(nil)}
        assert_match %r{missing}, ex.message
      end
    end
    
    context "with a Regular plan" do
      setup do
        @regular_plan = Spreedly::SubscriptionPlan.all.detect{|e| e.name == "Test Regular Plan"}
        assert @regular_plan, "For this test to pass in REAL mode you must have a regular plan in your Spreedly test site with the name \"Test Regular Plan\"."
      end

      should "stop auto renew for subscriber" do
        subscriber = create_subscriber
        subscriber.subscribe(@regular_plan.id)
        
        subscriber = Spreedly::Subscriber.find(subscriber.id)
        assert subscriber.active?
        assert subscriber.recurring

        subscriber.stop_auto_renew
        subscriber = Spreedly::Subscriber.find(subscriber.id)
        assert subscriber.active?
        assert !subscriber.recurring
      end
    end
    
    should "throw an error if stopping auto renew on a non-existent subscriber" do
      sub = Spreedly::Subscriber.new('customer_id' => 'bogus')
      ex = assert_raise(RuntimeError){sub.stop_auto_renew}
      assert_match %r{does not exist}, ex.message
    end

    only_real do
      should "throw an error if comp is wrong type" do
        sub = create_subscriber
        sub.comp(1, 'days')
        ex = assert_raise(RuntimeError) do
          sub.comp(1, 'days')
        end
        assert_match(/invalid/i, ex.message)
      end
    end
  end
  
  def create_subscriber(id=(rand*100000000).to_i, email=nil, screen_name=nil)
    Spreedly::Subscriber.create!(id, email, screen_name)
  end
end