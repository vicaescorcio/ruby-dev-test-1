class Asset < ApplicationRecord
    #attr_accessible :uploaded_file      
    belongs_to :folder
    has_attached_file :uploaded_file,
    :url => "/assets/get/:id", 
    :path => ":Rails_root/assets/:id/:basename.:extension"

    do_not_validate_attachment_file_type :uploaded_file
    validates_attachment_size :uploaded_file, :less_than => 10.megabytes   
    validates_attachment_presence :uploaded_file
    def file_name
        uploaded_file_file_name
    end
end
