class Racer
  include Mongoid::Document

  embeds_one :info, as: :parent, class_name: 'RacerInfo', autobuild: true
  has_many :races, class_name: 'Entrant', foreign_key: 'racer.racer_id',
    dependent: :nullify, order: :"race.date".desc #rspec not pass if array notation

  before_create :set_associated_info

  delegate :first_name, :first_name=, to: :info
  delegate :last_name, :last_name=, to: :info
  delegate :gender, :gender=, to: :info
  delegate :birth_year, :birth_year=, to: :info
  delegate :city, :city=, to: :info
  delegate :state, :state=, to: :info

  def set_associated_info
    self.info.id = self.id
  end
end
