class RacerInfo
  include Mongoid::Document
  field :fn, as: :first_name, type: String
  field :ln, as: :last_name, type: String
  field :g, as: :gender, type: String
  field :yr, as: :birth_year, type: Integer
  field :res, as: :residence, type: Address

  # store racer id in RacerInfo and Racer as _id
  field :racer_id, as: :_id
  field :_id, default:->{ racer_id }

  embedded_in :parent, polymorphic: true


  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :gender, presence: true, inclusion: { in: ["F", "M"],
    message: "must be F or M"}
  validates :birth_year, presence: true,
    numericality: { only_integer: true, less_than: Date.current.year }

  ['city','state'].each do |action|
    define_method("#{action}") do
      self.residence ? self.residence.send("#{action}") : nil
    end

    define_method("#{action}=") do |value|
      object=self.residence || Address.new
      object.send("#{action}=", value)
      self.residence=object
    end
  end
end
