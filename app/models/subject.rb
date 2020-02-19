class Subject < ApplicationRecord
  belongs_to :timetable
  belongs_to :experiment
  belongs_to :user, optional: true
  validates :timetable_id, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX}
  validate :correct_timetable
  validate :timetable_is_selectable, if: :will_save_change_to_timetable_id?

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
    ["start_at", "email", "gender", "birth_date", "note"]
  end

  def self.generate_csv
    CSV.generate(headers: true) do |csv|
      csv << csv_attributes
      all.each do |subject|
        csv << csv_attributes.map{ |attr| subject.send(attr) }
        #csv << subject.as_json(only: csv_attributes)
      end
    end
  end

  private
    def correct_timetable
      unless timetable.experiment == experiment
        errors[:base] << "開始時刻が不正な値です"
      end
    end
    
    def timetable_is_selectable
      #unless timetable.subjects.count < timetable.number_of_subjects
      unless timetable.selectable?
        errors[:base] << "その時間の実験は既に満席です"
      end
    end
end
