class WordAnswer < ApplicationRecord
  belongs_to :word
  belongs_to :lesson
  has_many :lesson_words
end
