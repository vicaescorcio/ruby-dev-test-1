class Folder < ApplicationRecord
    acts_as_tree 
    has_many :assets, dependent: :destroy
end
