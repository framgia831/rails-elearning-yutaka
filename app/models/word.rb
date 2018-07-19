class Word < ApplicationRecord
  belongs_to :category, optional: true
  has_many :word_answers
  validates :content,presence: true
  accepts_nested_attributes_for :word_answers
end
