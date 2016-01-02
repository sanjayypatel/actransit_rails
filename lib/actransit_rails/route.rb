class ACTransitRails::Route

  attr_accessor :id, :name, :description

  def initialize(id, name, description)
    @id = id
    @name = name
    @description = description
  end

  def self.new_from_api_response(hash)
    route = new(
      hash["RouteId"],
      hash["Name"],
      hash["Description"]
    )
    return route
  end

end