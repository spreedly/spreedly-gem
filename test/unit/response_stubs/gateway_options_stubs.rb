module GatewayOptionsStubs

  def successful_gateway_options_response
    StubResponse.succeeded <<-XML
      <gateways>
        <gateway>
          <gateway_type>paypal</gateway_type>
          <name>PayPal</name>
          <auth_modes>
            <auth_mode>
              <auth_mode_type>signature</auth_mode_type>
              <name>Signature</name>
              <credentials>
                <credential>
                  <name>login</name>
                  <label>Login</label>
                  <safe type="boolean">true</safe>
                </credential>
                <credential>
                  <name>password</name>
                  <label>Password</label>
                  <safe type="boolean">false</safe>
                </credential>
                <credential>
                  <name>signature</name>
                  <label>Signature</label>
                  <safe type="boolean">false</safe>
                </credential>
              </credentials>
            </auth_mode>
            <auth_mode>
              <auth_mode_type>certificate</auth_mode_type>
              <name>Certificate</name>
              <credentials>
                <credential>
                  <name>login</name>
                  <label>Login</label>
                  <safe type="boolean">true</safe>
                </credential>
                <credential>
                  <name>password</name>
                  <label>Password</label>
                  <safe type="boolean">false</safe>
                </credential>
                <credential>
                  <name>pem</name>
                  <label>PEM Certificate</label>
                  <safe type="boolean">false</safe>
                  <large type="boolean">true</large>
                </credential>
              </credentials>
            </auth_mode>
            <auth_mode>
              <auth_mode_type>delegate</auth_mode_type>
              <name>Delegate</name>
              <credentials>
                <credential>
                  <name>email</name>
                  <label>PayPal Email</label>
                  <safe type="boolean">true</safe>
                </credential>
              </credentials>
            </auth_mode>
          </auth_modes>
          <characteristics>
            <supports_purchase type="boolean">true</supports_purchase>
            <supports_authorize type="boolean">true</supports_authorize>
            <supports_capture type="boolean">true</supports_capture>
            <supports_credit type="boolean">true</supports_credit>
            <supports_void type="boolean">true</supports_void>
            <supports_reference_purchase type="boolean">true</supports_reference_purchase>
            <supports_purchase_via_preauthorization type="boolean">true</supports_purchase_via_preauthorization>
            <supports_offsite_purchase type="boolean">true</supports_offsite_purchase>
            <supports_offsite_authorize type="boolean">true</supports_offsite_authorize>
            <supports_3dsecure_purchase type="boolean">true</supports_3dsecure_purchase>
            <supports_3dsecure_authorize type="boolean">true</supports_3dsecure_authorize>
            <supports_store type="boolean">true</supports_store>
            <supports_remove type="boolean">false</supports_remove>
          </characteristics>
          <payment_methods>
            <payment_method>credit_card</payment_method>
            <payment_method>paypal</payment_method>
          </payment_methods>
          <gateway_specific_fields>
            <gateway_specific_field>recurring</gateway_specific_field>
          </gateway_specific_fields>
          <supported_countries>US, GB, CA</supported_countries>
          <regions>europe, north_america</regions>
          <homepage>http://paypal.com/</homepage>
          <company_name>Paypal Inc.</company_name>
        </gateway>
        <gateway>
          <gateway_type>worldpay</gateway_type>
          <name>WorldPay</name>
          <auth_modes>
            <auth_mode>
              <auth_mode_type>default</auth_mode_type>
              <name>Default</name>
              <credentials>
                <credential>
                  <name>login</name>
                  <label>Login</label>
                  <safe type="boolean">true</safe>
                </credential>
                <credential>
                  <name>password</name>
                  <label>Password</label>
                  <safe type="boolean">false</safe>
                </credential>
              </credentials>
            </auth_mode>
          </auth_modes>
          <characteristics>
            <supports_purchase type="boolean">true</supports_purchase>
            <supports_authorize type="boolean">true</supports_authorize>
            <supports_capture type="boolean">true</supports_capture>
            <supports_credit type="boolean">true</supports_credit>
            <supports_void type="boolean">true</supports_void>
            <supports_reference_purchase type="boolean">true</supports_reference_purchase>
            <supports_purchase_via_preauthorization type="boolean">false</supports_purchase_via_preauthorization>
            <supports_offsite_purchase type="boolean">false</supports_offsite_purchase>
            <supports_offsite_authorize type="boolean">false</supports_offsite_authorize>
            <supports_3dsecure_purchase type="boolean">false</supports_3dsecure_purchase>
            <supports_3dsecure_authorize type="boolean">false</supports_3dsecure_authorize>
            <supports_store type="boolean">false</supports_store>
            <supports_remove type="boolean">false</supports_remove>
          </characteristics>
          <payment_methods>
            <payment_method>credit_card</payment_method>
          </payment_methods>
          <gateway_specific_fields/>
          <supported_countries>HK, US, GB, AU, AD, BE, CH, CY, CZ, DE, DK, ES, FI, FR, GI, GR, HU, IE, IL, IT, LI, LU, MC, MT, NL, NO, NZ, PL, PT, SE, SG, SI, SM, TR, UM, VA</supported_countries>
          <regions>latin_america</regions>
          <homepage>http://worldpay.com</homepage>
          <company_name>Worldpay</company_name>
        </gateway>
      </gateways>
    XML
  end

end
