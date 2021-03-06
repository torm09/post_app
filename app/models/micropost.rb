class Micropost < ActiveRecord::Base
  belongs_to :user
  validates :content, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true
  mount_uploader :picture, PictureUploader
  default_scope -> { order('created_at DESC') }
  validate  :picture_size

  private

    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
end
