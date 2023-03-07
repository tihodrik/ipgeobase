# frozen_string_literal: true

require 'happymapper'

module Ipgeobase
  class Metadata
    include HappyMapper

    tag 'query'
    element :countryCode, String, tag: 'countryCode'
    element :country, String, tag: 'country'
    element :city, String, tag: 'city'
    element :lat, String, tag: 'lat'
    element :lon, String, tag: 'lon'
  end
end
