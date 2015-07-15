require "actransit_rails/version"

class ActransitRails


  def initialize(actransit_token)
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
      my_token
    )
    return get_response(uri)
  end

  private

  def base_url
    return "http://api.actransit.org/transit/"
  end

  def search_string
    "?"
  end

  def my_token
    return "token=" + ENV["ACTRANSIT_TOKEN"]
  end

  def get_response(uri)
    http = Net::HTTP.new(uri.host, uri.port)
    response = http.request(Net::HTTP::Get.new(uri.request_uri))
    return JSON.parse response.body
  end
end
