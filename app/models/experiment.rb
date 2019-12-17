class Experiment < ApplicationRecord
  belongs_to :user
  has_many :subjects, dependent: :destroy
  accepts_nested_attributes_for :subjects
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :name, presence: true, length: { maximum: 255 }
  validate :picture_size

  private

    # アップロードされた画像のサイズをバリデーションする
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
end
