class Subject < ApplicationRecord
  belongs_to :timetable
  has_one :experiment, through: :timetable
  validates :timetable_id, presence: true
  validates :email, presence: true
  validate :selectable_timetable

  def start_at
    timetable.start_at
  end
  
  def gender
    case sex
    when '0' then
      return ""
    when '1' then
      return "男性"
    when '2' then
      return "女性"
    else
      return "その他"
    end
  end
  
  def self.csv_attributes
    ["start_at", "email", "gender", "birth_date"]
  end

  def self.generate_csv
    CSV.generate(headers: true) do |csv|
      csv << csv_attributes
      all.each do |subject|
        csv << csv_attributes.map{ |attr| subject.send(attr) }
      end
    end
  end

  private
    def selectable_timetable
      unless timetable.subjects.count < timetable.number_of_subjects
        errors[:base] << "その時間の実験は既に満席です"
      end
    end
end
