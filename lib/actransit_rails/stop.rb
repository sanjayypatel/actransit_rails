class ACTransitRails::Stop

  attr_accessor :id, :name, :latitude, :longitude, :scheduled_time

  def initialize(id, name, latitude, longitude, schedule_type)
    @id = id
    @name = name
    @latitude = latitude
    @longitude = longitude
    @schedule_time = scheduled_time
  end

  def self.new_from_api_response(hash)
    stop = new(
      hash["StopId"],
      hash["Name"],
      hash["Latitude"],
      hash["Longitude"],
      hash["ScheduledTime"]
    )
    return stop
  end

end