class Placing
  attr_accessor :name, :place
  def initialize name, place
    @name = name
    @place = place
  end

  def mongoize
    {name: @name, place: @place}
  end

  def self.demongoize(object)
    Placing.new(object[:name], object[:place].to_i) if object
  end

  def self.mongoize(object)
    case object
    when Placing then object.mongoize
    when Hash then Placing.demongoize(object).mongoize
    else object
    end
  end

  def self.evolve(object)
    mongoize(object)
  end
end
