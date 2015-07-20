require "actransit_rails/version"
require "actransit_rails/exceptions"
require 'json'

module ACTransitRails

  attr_writer :actransit_token

  def self.configure(actransit_token)
    @actransit_token = actransit_token
  end

  def self.get_all_routes
    uri = URI.parse(
      base_url + 
      "routes/" + 
      search_string + 
      my_token
    )
    return get_response(uri)
  end

  def self.get_route(route_name)
    uri = URI.parse(
      base_url + 
      "route/" + 
      "#{route_name}/" + 
      search_string + 
      my_token
    )
    return get_response(uri)
  end

  def self.get_trips(route_name)
    uri = URI.parse(
      base_url + 
      "route/" + 
      "#{route_name}/trips/" + 
      search_string + 
      my_token
    )
    return get_response(uri)
  end

  def self.get_directions(route_name)
    uri = URI.parse(
      base_url + 
      "route/" + 
      "#{route_name}/directions/" + 
      search_string + 
      my_token
    )
    return get_response(uri)
  end

  def self.get_stops(route_name, trip = nil)
    trip ||= get_trips(route_name)[0]["TripId"]
    uri = URI.parse(
      base_url + 
      "route/" + 
      "#{route_name}/trip/" + 
      "#{trip}/stops/" + 
      search_string + 
      my_token +
      response_format
    )
    return get_response(uri)
  end

  private

  def self.base_url
    return "http://api.actransit.org/transit/"
  end

  def self.search_string
    "?"
  end

  def self.my_token
    return "token=" + @actransit_token
  end

  def self.response_format
    return "&format=json"
  end

  def self.get_response(uri)
    http = Net::HTTP.new(uri.host, uri.port)
    http_response = http.request(Net::HTTP::Get.new(uri.request_uri))
    return process_response(http_response)
  end

  def self.process_response(http_response)
    code = "#{http_response.code}"
    message = ""
    case (http_response.code)
    when '200'
      return JSON.parse http_response.body
    when '401'
      message = http_response.body
    when '404'
      message = "Not found. No results for your query."
    end
    raise ACTransitRails::APIAccessError.new(message, code)
  end

end
