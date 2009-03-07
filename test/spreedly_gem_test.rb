require 'test/unit'
require 'shoulda'
require 'yaml'
require 'pp'

require 'spreedly'

Spreedly.mock! unless ENV["SPREEDLY_TEST"] == "REAL"

test_site = YAML.load(File.read(File.dirname(__FILE__) + '/test_site.yml'))
Spreedly.configure(test_site['name'], test_site['token'])
Spreedly::Subscriber.wipe!

class SpreedlyGemTest < Test::Unit::TestCase
  context "A Spreedly site" do
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
      assert_match /exists/i, ex.message
    end
    
    should "raise error if subscriber is invalid" do
      ex = assert_raise(RuntimeError) do
        create_subscriber(:id => '')
      end
      assert_match /validation/i, ex.message
    end
    
    should "create with additional params" do
      subscriber = create_subscriber(:id => "fred", :screen_name => "FREDDY", :email => "fred@example.com")
      assert_equal "FREDDY", subscriber.screen_name
      assert_equal "fred@example.com", subscriber.email
    end
  end
  
  def create_subscriber(params = {:id => (rand*100000000).to_i})
    Spreedly::Subscriber.create!(params)
  end
end