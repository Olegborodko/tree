class Dot < ActiveRecord::Base
	has_one :relation, dependent: :destroy
	validates_presence_of :name
end
