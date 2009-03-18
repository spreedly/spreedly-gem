require 'test/unit'
require 'shoulda'
require 'yaml'
require 'pp'

if ENV["SPREEDLY_TEST"] == "REAL"
  require 'spreedly'
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

    should "add a subscriber" do
      subscriber = Spreedly::Subscriber.create!(:id => 'joe')
      assert_not_nil subscriber.token
      assert_equal subscriber.token, Spreedly::Subscriber.find('joe').token
    end
    
    should "get a subscriber" do
      id = create_subscriber.id
      subscriber = Spreedly::Subscriber.find(id)
      assert_nil subscriber.active_until
    end
    
    should "expose and parse attributes" do
      subscriber = create_subscriber
      assert_kind_of Time, subscriber.created_at
      assert_equal false, subscriber.active
      assert_equal BigDecimal('0.0'), subscriber.store_credit
    end
    
    should "raise error if subscriber exists" do
      create_subscriber(:id => 'bob')
      ex = assert_raise(RuntimeError) do
        create_subscriber(:id => 'bob')
      end
      assert_match(/exists/i, ex.message)
    end
    
    should "raise error if subscriber is invalid" do
      ex = assert_raise(RuntimeError) do
        create_subscriber(:id => '')
      end
      assert_match(/no id/i, ex.message)
    end
    
    should "create with additional params" do
      subscriber = create_subscriber(:id => "fred", :screen_name => "FREDDY", :email => "fred@example.com")
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
        Spreedly.subscribe_url(:id => 'joe', :plan => '1', :screen_name => "Joe Bob")
      assert_equal "https://spreedly.com/terralien-test/subscribers/joe/subscribe/1/",
        Spreedly.subscribe_url(:id => 'joe', :plan => '1')
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
      sub.comp(:duration_quantity => 1, :duration_units => 'days', :feature_level => 'Sweet!')
      sub = Spreedly::Subscriber.find(sub.id)
      assert_not_nil sub.active_until
      assert_equal 'Sweet!', sub.feature_level
      assert sub.active?
    end
    
    should "comp an active subscriber" do
      sub = create_subscriber
      assert !sub.active?
      sub.comp(:duration_quantity => 1, :duration_units => 'days')

      sub = Spreedly::Subscriber.find(sub.id)
      assert sub.active?
      old_active_until = sub.active_until
      sub.comp(:duration_quantity => 1, :duration_units => 'days')

      sub = Spreedly::Subscriber.find(sub.id)
      assert sub.active?
      assert old_active_until < sub.active_until
    end
    
    should "throw an error if comp is against unknown subscriber" do
      sub = create_subscriber
      Spreedly::Subscriber.wipe!
      ex = assert_raise(RuntimeError) do
        sub.comp(:duration_quantity => 1, :duration_units => 'days')
      end
      assert_match(/exists/i, ex.message)
    end
    
    should "throw an error if comp is invalid" do
      sub = create_subscriber
      ex = assert_raise(RuntimeError) do
        sub.comp
      end
      assert_match(/validation/i, ex.message)
      assert_raise(RuntimeError){sub.comp(:duration_quantity => 1)}
      assert_raise(RuntimeError){sub.comp(:duration_units => 1)}
    end
    
    should "return subscription plans" do
      assert !Spreedly::SubscriptionPlan.all.empty?
      assert_not_nil Spreedly::SubscriptionPlan.all.first.name
    end
    
    only_real do
      should "throw an error if comp is wrong type" do
        sub = create_subscriber
        sub.comp(:duration_quantity => 1, :duration_units => 'days')
        ex = assert_raise(RuntimeError) do
          sub.comp(:duration_quantity => 1, :duration_units => 'days')
        end
        assert_match(/invalid/i, ex.message)
      end
    end
  end
  
  def create_subscriber(params = {:id => (rand*100000000).to_i})
    Spreedly::Subscriber.create!(params)
  end
end