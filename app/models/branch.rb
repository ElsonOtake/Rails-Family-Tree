class Branch < ApplicationRecord
  belongs_to :leaf
  belongs_to :pair
end
