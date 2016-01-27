class Image < ActiveRecord::Base
	belongs_to :imageable, :polymorphic => true
	has_attached_file :photo, styles: { small: "64x64", med: "100x100", large: "200x200" }

	validates_attachment_presence :photo
	validates_attachment_size :photo,  :less_than => 5.megabytes
	validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/jpg', 'image/png', 'image/gif']

	validates :imageable_type, :presence => true
	validates :imageable_id, :presence => true

	default_scope -> { order('position') }
end
