class LegResult
  include Mongoid::Document
  field :secs, type: Float
  embedded_in :entrant
  embeds_one :event, as: :parent
  validates :event, presence: true

  after_initialize :calc_ave

  def calc_ave
    #subclasses will calc event-specific ave
  end

  def secs= value
    self[:secs] = value
    calc_ave
  end
end
