class Relationship < ApplicationRecord
  belongs_to :examiner, class_name: "User"
  belongs_to :examinee, class_name: "User"
  validates :examiner_id, presence: true
  validates :examinee_id, presence: true
end
