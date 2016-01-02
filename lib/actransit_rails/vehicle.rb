class ACTransitRails::Vehicle

  attr_accessor :id, :current_trip_id, :latitude, :longitude, :heading, :time_last_reported

  def initialize(id, current_trip_id, latitude, longitude, heading, time_last_reported)
    @id = id
    @current_trip_id = current_trip_id
    @latitude = latitude
    @longitude = longitude
    @heading = heading
    @time_last_reported = time_last_reported
  end

  def self.new_from_api_response(hash)
    vehicle = new(
      hash["VehicleId"],
      hash["CurrentTripId"],
      hash["Latitude"],
      hash["Longitude"],
      hash["Heading"],
      hash["TimeLastReported"]
    )
    return vehicle
  end

end