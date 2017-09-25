class Room < ActiveRecord::Base
	mount_uploader :image,ImageUploader

	 ransacker :numero do
    Arel.sql("to_char(\"#{table_name}\".\"numero\", '99999')")
  end
def self.search(search)
  where("name ILIKE ?  OR description ILIKE ?", "%#{search}%", "%#{search}%") 
end

end
