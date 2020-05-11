class Customer < ApplicationRecord
	belongs_to :users, optional: true
	validates :organisation_name, uniqueness: {:case_sensitive => false}, presence: true

	#
	# Business logic methods here
	#
end
