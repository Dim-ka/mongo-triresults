class Address
  attr_accessor :city, :state, :location
  def initialize city=nil, state=nil, location=nil
    @city = city
    @state = state
    @location = location
  end

  def mongoize
    {city: @city, state: @state, loc: @location.mongoize}
  end

  def self.demongoize(object)
    if object
      Address.new(object[:city], object[:state],
                  Point.demongoize(object[:loc]))
    end
  end

  def self.mongoize(object)
    case object
    when Address then object.mongoize
    when Hash then Address.demongoize(object).mongoize
    else object
    end
  end

  def self.evolve(object)
    Address.mongoize(object)
  end
end
