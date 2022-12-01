class Leaf < ApplicationRecord
  include ActiveModel::Serializers::JSON
  attr_accessor :parents, :children, :partner, :siblings

  has_many :leaf1_pairs, class_name: 'Pair', foreign_key: 'leaf1_id'
  has_many :leaf2_pairs, class_name: 'Pair', foreign_key: 'leaf2_id'
  validates :name, presence: true
  validates :gender, presence: true,
                     inclusion: { in: %w[M F P U], message: '%<value>s is not a valid gender (M/F/P/U)' }
  validates :alive, presence: true, inclusion: { in: %w[S N], message: '%<value>s is not a valid input (S/N)' }
end
