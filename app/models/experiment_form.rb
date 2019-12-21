class ExperimentForm < Form

  DEFAULT_ITEM_COUNT = 3

  attr_accessor :experiment
  attr_accessor :timetables

  def initialize(attributes = {})
    super attributes
    self.experiment = Experiment.new unless experiment.present?
    self.timetables = DEFAULT_ITEM_COUNT.times.map { experiment.timetables.new } unless timetables.present?
  end

  def experiment_attributes=(attributes)
    self.experiment = Experiment.new(attributes)
  end

  def timetables_attributes=(attributes)
    self.timetables = attributes.map do |_, timetable_attributes|
      self.experiment.timetables.new(timetable_attributes)
    end
  end

  def valid?
    valid_timetables = target_timetables.map(&:valid?).all?
    experiment.valid? && valid_timetables
  end

  def save
    return false unless valid?
    experiment.save!
    Timetable.transaction { target_timetables.each(&:save!) }
    true
  end

  def target_timetables
    self.timetables.select{ |v| v.start_at!=nil }
  end
end