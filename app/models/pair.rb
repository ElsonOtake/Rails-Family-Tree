class Pair < ApplicationRecord
  belongs_to :leaf1, class_name: 'Leaf'
  belongs_to :leaf2, class_name: 'Leaf'
  has_many :branches
end
