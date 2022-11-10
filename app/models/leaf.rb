class Leaf < ApplicationRecord
  has_many :leaf1_pairs, class_name: 'Pair', foreign_key: 'leaf1_id'
  has_many :leaf2_pairs, class_name: 'Pair', foreign_key: 'leaf2_id'
end
