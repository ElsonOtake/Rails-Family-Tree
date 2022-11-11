class Pair < ApplicationRecord
  # belongs_to :leaf1_id
  # belongs_to :leaf2_id
  belongs_to :leaf1, class_name: 'Leaf'
  belongs_to :leaf2, class_name: 'Leaf'
end
