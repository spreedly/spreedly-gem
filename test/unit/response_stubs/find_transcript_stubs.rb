module FindTranscriptStubs

  def successful_get_transcript_response
    StubResponse.succeeded <<-TEXT
   opening connection to api-aa.paypal.com...
    opened
    <- "POST /2.0/ HTTP/1.1
Accept: */*
Connection: close
Content-Type: application/x-www-form-urlencoded
Content-Length: 1716
Host: api-aa.paypal.com

"
    <- "<?xml version="1.0" encoding="UTF-8"?><env:Envelope xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:env="http://schemas.xmlsoap.org/soap/envelope/"><env:Header><RequesterCredentials env:mustUnderstand="0" xmlns:n1="urn:ebay:apis:eBLBaseComponents" xmlns="urn:ebay:api:PayPalAPI"><n1:Credentials><Username>duff_api1.omelia.org</Username><Password>BLDBYVD89NSC42XG</Password><Subject></Subject></n1:Credentials></RequesterCredentials></env:Header><env:Body><DoDirectPaymentReq xmlns="urn:ebay:api:PayPalAPI">
  <DoDirectPaymentRequest xmlns:n2="urn:ebay:apis:eBLBaseComponents">
    <n2:Version>59.0</n2:Version>
    <n2:DoDirectPaymentRequestDetails>
      <n2:PaymentAction>Sale</n2:PaymentAction>
      <n2:PaymentDetails>
        <n2:OrderTotal currencyID="USD">0.08</n2:OrderTotal>
        <n2:NotifyURL></n2:NotifyURL>
        <n2:OrderDescription></n2:OrderDescription>
        <n2:InvoiceID></n2:InvoiceID>
        <n2:ButtonSource>ActiveMerchant</n2:ButtonSource>
      </n2:PaymentDetails>
      <n2:CreditCard>
        <n2:CreditCardType>MasterCard</n2:CreditCardType>
        <n2:CreditCardNumber>[FILTERED]</n2:CreditCardNumber>
        <n2:ExpMonth>04</n2:ExpMonth>
        <n2:ExpYear>2012</n2:ExpYear>
        <n2:CVV2>[FILTERED]</n2:CVV2>
        <n2:CardOwner>
          <n2:PayerName>
            <n2:FirstName>John</n2:FirstName>
            <n2:LastName>Jones</n2:LastName>
          </n2:PayerName>
          <n2:Payer></n2:Payer>
        </n2:CardOwner>
      </n2:CreditCard>
      <n2:IPAddress>127.0.0.1</n2:IPAddress>
    </n2:DoDirectPaymentRequestDetails>
  </DoDirectPaymentRequest>
</DoDirectPaymentReq>
</env:Body></env:Envelope>"
    -> "HTTP/1.1 200 OK
"
    -> "Date: Sat, 12 Feb 2011 22:59:52 GMT
"
    -> "Server: Apache
"
    -> "Content-Length: 1866
"
    -> "Connection: close
"
    -> "Content-Type: text/xml; charset=utf-8
"
    -> "
"
    reading 1866 bytes...
    -> "<?xml version="1.0" encoding="UTF-8"?><SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:cc="urn:ebay:apis:CoreComponentTypes" xmlns:wsu="http://schemas.xmlsoap.org/ws/2002/07/utility" xmlns:saml="urn:oasis:names:tc:SAML:1.0:assertion" xmlns:ds="http://www.w3.org/2000/09/xmldsig#" xmlns:wsse="http://schemas.xmlsoap.org/ws/2002/12/secext" xmlns:ed="urn:ebay:apis:EnhancedDataTypes" xmlns:ebl="urn:ebay:apis:eBLBaseComponents" xmlns:ns="urn:ebay:api:PayPalAPI"><SOAP-ENV:Header><Security xmlns="http://schemas.xmlsoap.org/ws/2002/12/secext" xsi:type="wsse:SecurityType"></Security><RequesterCredentials xmlns="urn:ebay:api:PayPalAPI" xsi:type="ebl:CustomSecurityHeaderType"><Credentials xmlns="urn:ebay:apis:eBLBaseComponents" xsi:type="ebl:UserIdPasswordType"><Username xsi:type="xs:string"></Username><Password xsi:type="xs:string"></Password><Subject xsi:type="xs:string"></Subject></Credentials></RequesterCredentials></SOAP-ENV:Header><SOAP-ENV:Body id="_0"><DoDirectPaymentResponse xmlns="urn:ebay:api:PayPalAPI"><Timestamp xmlns="urn:ebay:apis:eBLBaseComponents">2011-02-12T22:59:54Z</Timestamp><Ack xmlns="urn:ebay:apis:eBLBaseComponents">Success</Ack><CorrelationID xmlns="urn:ebay:apis:eBLBaseComponents">4b1abc59de85e</CorrelationID><Version xmlns="urn:ebay:apis:eBLBaseComponents">59.0</Version><Build xmlns="urn:ebay:apis:eBLBaseComponents">1704252</Build><Amount xsi:type="cc:BasicAmountType" currencyID="USD">0.08</Amount><AVSCode xsi:type="xs:string">G</AVSCode><CVV2Code xsi:type="xs:string">M</CVV2Code><TransactionID>5RD773886M510011H</TransactionID></DoDirectPaymentResponse></SOAP-ENV:Body></SOAP-ENV:Envelope>"
    read 1866 bytes
    Conn close
    TEXT
  end
end
