require 'test_helper'

class FieldsTest < Test::Unit::TestCase

  class ModelWithFields
    include Spreedly::Fields
    field :message, :amount, :on_test_gateway, :updated_at, :succeeded, :field_not_in_response
  end

  class ModelWithTypedFields
    include Spreedly::Fields
    field :message, :string_field_not_in_response
    field :succeeded, :on_test_gateway, :boolean_field_not_in_response, type: :boolean
    field :amount, :integer_field_not_in_response, type: :integer
    field :updated_at, :date_time_field_not_in_response, type: :date_time
  end

  def setup
    @model = ModelWithFields.new
    @typed_model = ModelWithTypedFields.new
  end

  def test_defaults_to_nil
    assert_nil @model.message
    assert_nil @model.amount
    assert_nil @model.on_test_gateway
    assert_nil @model.updated_at
    assert_nil @model.succeeded
    assert_nil @model.field_not_in_response
  end

  def test_defaults_to_nil_for_typed_fields
    assert_nil @typed_model.message
    assert_nil @typed_model.amount
    assert_nil @typed_model.on_test_gateway
    assert_nil @typed_model.on_test_gateway?
    assert_nil @typed_model.updated_at
    assert_nil @typed_model.succeeded
    assert_nil @typed_model.succeeded?
    assert_nil @typed_model.string_field_not_in_response
    assert_nil @typed_model.boolean_field_not_in_response
    assert_nil @typed_model.integer_field_not_in_response
    assert_nil @typed_model.date_time_field_not_in_response
  end

  def test_initialize_fields_for_strings
    @model.initialize_fields(Nokogiri::XML(xml))
    assert_equal "The eagle flies at dawn.", @model.message
    assert_equal "5148", @model.amount
    assert_equal "true", @model.on_test_gateway
    assert_equal "2013-07-31T19:51:57Z", @model.updated_at
    assert_equal "false", @model.succeeded
    assert_nil @model.field_not_in_response
  end

  def test_initialize_fields_for_typed_fields
    @typed_model.initialize_fields(Nokogiri::XML(xml))
    assert_equal "The eagle flies at dawn.", @typed_model.message
    assert_equal 5148, @typed_model.amount
    assert_equal true, @typed_model.on_test_gateway
    assert_equal true, @typed_model.on_test_gateway?
    assert_equal Time.parse("2013-07-31T19:51:57Z"), @typed_model.updated_at
    assert_equal false, @typed_model.succeeded
    assert_equal false, @typed_model.succeeded?
    
    assert_nil @typed_model.string_field_not_in_response
    assert_nil @typed_model.boolean_field_not_in_response
    assert_nil @typed_model.integer_field_not_in_response
    assert_nil @typed_model.date_time_field_not_in_response
  end

  private
  def xml
    <<-XML
      <the_model>
        <amount>5148</amount>
        <on_test_gateway>true</on_test_gateway>
        <updated_at>2013-07-31T19:51:57Z</updated_at>
        <succeeded>false</succeeded>
        <message>The eagle flies at dawn.</message>
      </the_model>
    XML
  end

end
