# frozen_string_literal: true

require_relative 'ipgeobase/version'
require_relative 'ipgeobase/geodata'
require 'net/http'

# main
module Ipgeobase
  def self.lookup(ip_address)
    uri = URI("http://ip-api.com/xml/#{ip_address}")
    response = Net::HTTP.get_response(uri)
    return Geodata.parse(response.body, single: true) if response.is_a?(Net::HTTPSuccess)

    raise StandardError, 'HTTP Request Failed'
  end
end
