# frozen_string_literal: true

require 'test_helper'

# Testing gem
class TestIpgeobase < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Ipgeobase::VERSION
  end

  def test_that_it_parse_address_metadata
    stub_request(:get, 'http://ip-api.com/xml/8.8.8.8')
      .with(
        headers: {
          'Accept' => '*/*',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Host' => 'ip-api.com',
          'User-Agent' => 'Ruby'
        }
      )
      .to_return(status: 200, body: '<?xml version=\'1.0\' encoding=\'UTF-8\'?>
                                    <query>
                                      <status>success</status>
                                      <country>United States</country>
                                      <countryCode>US</countryCode>
                                      <city>Ashburn</city>
                                      <zip>20149</zip>
                                      <lat>39.03</lat>
                                      <lon>-77.5</lon>
                                      <query>8.8.8.8</query>
                                    </query>
      ', headers: {})
    ip_meta = Ipgeobase.lookup('8.8.8.8')
    assert_equal ip_meta.city, 'Ashburn'
    assert_equal ip_meta.country, 'United States'
    assert_equal ip_meta.countryCode, 'US'
    assert_equal ip_meta.lat, '39.03'
    assert_equal ip_meta.lon, '-77.5'
  end

  def test_that_it_raise_error_on_incorrect_api_response
    stub_request(:get, 'http://ip-api.com/xml/8.8.8.8')
      .with(
        headers: {
          'Accept' => '*/*',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Host' => 'ip-api.com',
          'User-Agent' => 'Ruby'
        }
      )
      .to_return(status: 500, body: '', headers: {})

    assert_raises 'HTTP Request Failed' do
      Ipgeobase.lookup('8.8.8.8')
    end
  end
end
