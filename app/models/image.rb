class Image < ActiveRecord::Base
	belongs_to :imageable, :polymorphic => true
	has_attached_file :photo, PAPERCLIP_STORAGE_OPTS

	validates_attachment_presence :photo
	validates_attachment_size     :photo, :less_than => 5.megabytes
	validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/jpg', 'image/png', 'image/gif']

	validates :imageable_type,  :presence => true
	validates :imageable_id,    :presence => true
	validate :validate_photo

	attr_accessor :photo_link


	default_scope -> { order('position') }

	after_post_process :find_dimensions
  	MAIN_LOGO = 'logo'

  	def photo_form_link(val)
  		if !val.blank?
  			self.photo_link = val
      		self.photo = open(val)
  		end
  	end

  	def photo_form_link
  		self.photo_link || ''		
  	end
	
	def find_dimensions
	    temporary = photo.queued_for_write[:original]
	    filename = temporary.path unless temporary.nil?
	    filename = photo.path if filename.blank?
	    geometry = Paperclip::Geometry.from_file(filename)
	    self.image_width  = geometry.width
	    self.image_height = geometry.height
	end

	def validate_photo
	unless photo.errors.empty?
	  # uncomment this to get rid of the less-than-useful interrim messages
	  # errors.clear
	  errors.add :attachment, "Paperclip returned errors for file '#{photo_file_name}' - check ImageMagick installation or image source file."
	  false
	end
	end
end
