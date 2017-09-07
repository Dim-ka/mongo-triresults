class Event
  include Mongoid::Document
  field :o, as: :order, type: Integer
  field :n, as: :name, type: String
  field :d, as: :distance, type: Float
  field :u, as: :units, type: String
  embedded_in :parent, polymorphic: true, touch: true
  validates :order, presence: true
  validates :name, presence: true

  def meters; convert_to :meters; end

  def miles; convert_to :miles; end

  def convertable?
    ['meters', 'kilometers', 'miles', 'yards'].include? units
  end

  private

    def convert_to metric
      return nil unless convertable?

      dimensions = {
        meters:     { meters: 1,        miles: 0.000621371 },
        miles:      { meters: 1609.344, miles: 1           },
        kilometers: { meters: 1000,     miles: 0.621371    },
        yards:      { meters: 0.9144,   miles: 0.000568182 }
      }
      distance * dimensions[units.to_sym][metric]
    end
end
