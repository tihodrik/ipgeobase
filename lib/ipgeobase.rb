# frozen_string_literal: true

require_relative 'ipgeobase/version'
require_relative 'ipgeobase/geodata'
require 'net/http'

module Ipgeobase
  SERVICE_URL = 'http://ip-api.com/xml'

  def self.lookup(ip_address)
    uri = URI("#{SERVICE_URL}/#{ip_address}")
    response = Net::HTTP.get_response(uri)
    return Geodata.parse(response.body, single: true) if response.is_a?(Net::HTTPSuccess)

    raise StandardError, 'HTTP Request Failed'
  end
end
