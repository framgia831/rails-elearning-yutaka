class Lesson < ApplicationRecord
	belongs_to :user
	belongs_to :category
	has_many :lesson_words
	has_many :word_answers, through: :lesson_words
	def correct_answers
		word_answers.where(correct: true)
	end
end
