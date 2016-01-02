class ACTransitRails::Trip

  attr_accessor :id, :route_name, :schedule_type, :start_time, :direction

  def initialize(id, route_name, schedule_type, start_time, direction)
    @id = id
    @route_name = route_name
    @schedule_type = schedule_type
    @start_time = start_time
    @direction = direction
  end

  def self.new_from_api_response(hash)
    trip = new(
      hash["TripId"],
      hash["RouteName"],
      hash["ScheduleType"],
      hash["StartTime"],
      hash["Direction"]
    )
    return trip
  end

end