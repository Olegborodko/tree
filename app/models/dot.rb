class Dot < ActiveRecord::Base
	has_one :relation
	validates_presence_of :name
end
