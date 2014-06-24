require 'test_helper'

class RemoteDeliverReceiverTest < Test::Unit::TestCase

  def setup
    @environment = Spreedly::Environment.new('TgSDJO8cpF9eehGGhnkd6HCs0HS', 'OSSdlheP4gThug0Ly4i5tmaEPM48KseBYFMb90fQVKJ7u49yxlyfxuzOHlceaa1s')
    # @environment = Spreedly::Environment.new(remote_test_environment_key, remote_test_access_secret)

  end

  def test_successfully_find_transcript
    receiver = @environment.add_receiver(:test, 'https://api-sandbox.networkforgood.org/PartnerDonationService/DonationServices.asmx', receiver_test_credentials)

    t = @environment.add_credit_card(card_deets)

    card_token = t.payment_method.token



    transaction = @environment.deliver_receiver(
        receiver_token: receiver.token,
        payment_method_token: card_token,
        receiver_headers: headers,
        url: url,
        receiver_body: receiver_body)

    p transaction
    assert(true.to_s, transaction.succeeded?)
  end

  private

  def receiver_test_credentials
    [
    { name: 'partner_id', value: 'G!V3C0RP5', safe: 'true' },
    { name: 'partner_password', value: 'qAAJ6yWN'},
    { name: 'partner_source', value: 'GCORPS'},
    { name: 'partner_campaign', value: 'DNTAPI', safe: 'true' }
    ]
  end

  def card_deets(options = {})
    {
      email: 'perrin@wot.com', number: '4111111111111111', month: 1, year: 2019,
      last_name: 'Aybara', first_name: 'Perrin'
    }.merge(options)
  end

  def headers
    {
      'Host' => 'https://api-sandbox.networkforgood.org',
      'Content-Length' => 1024,
      'Content-Type' => 'application/soap+xml; charset=utf-8',
      'SOAPAction' => "#{url.gsub('.asmx','')}/CreateCOF"
    }
  end

  def url
    'https://api-sandbox.networkforgood.org/PartnerDonationService/DonationServices.asmx'
  end

  def receiver_body
    <<-XML
      <?xml version="1.0" encoding="utf-8"?>
      <soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">
        <soap12:Body>
          <CreateCOF xmlns="http://api.networkforgood.org/partnerdonationservice">
            <PartnerID>{{ partner_id }}</PartnerID>
            <PartnerPW>{{ partner_password }}</PartnerPW>
            <PartnerSource>{{ partner_source }}</PartnerSource>
            <PartnerCampaign>{{ partner_campaign }}</PartnerCampaign>
            <DonorToken>SISUDHDIID</DonorToken>
            <DonorFirstName>{{ credit_card_first_name }}</DonorFirstName>
            <DonorLastName>{{ credit_card_last_name }}</DonorLastName>
            <DonorEmail>test@thos.com</DonorEmail>
            <DonorAddress1>123 This Street</DonorAddress1>
            <DonorAddress2></DonorAddress2>
            <DonorCity>Baltimore</DonorCity>
            <DonorState>MD</DonorState>
            <DonorZip>21222</DonorZip>
            <DonorCountry>US</DonorCountry>
            <DonorPhone>410-555-1212</DonorPhone>
            <CardType>Visa</CardType>
            <NameOnCard>{{ credit_card_first_name }} {{ credit_card_last_name }}</NameOnCard>
            <CardNumber>{{ credit_card_number }}</CardNumber>
            <ExpMonth>{{ credit_card_month }}</ExpMonth>
            <ExpYear>{{ credit_card_year }}</ExpYear>
            <CSC>{{ credit_card_verification_value }}</CSC>
          </CreateCOF>
        </soap12:Body>
      </soap12:Envelope>
    XML
  end


end
