class Experiment < ApplicationRecord
  belongs_to :user
  has_many :timetables, dependent: :destroy
  has_many :subjects, through: :timetables
  attr_accessor :number_of_subjects
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :name, presence: true, length: { maximum: 255 }
  validate :picture_size

  accepts_nested_attributes_for :timetables, allow_destroy: true
  
  REGISTRABLE_ATTRIBUTES = %i(name description deadline picture number_of_subjects)

  def selectable_timetables
    timetables.select{ |timetable| timetable.subjects.count < timetable.number_of_subjects }
  end
    
    private

    # アップロードされた画像のサイズをバリデーションする
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
end
