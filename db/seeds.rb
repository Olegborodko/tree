# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Dot.delete_all
Dot.create(id: 1, name: '1')
Dot.create(id: 2, name: '2')
Dot.create(id: 3, name: '3')
Dot.create(id: 4, name: '4')
Dot.create(id: 5, name: '5')
Dot.create(id: 6, name: '6')
Dot.create(id: 7, name: '7')
Dot.create(id: 8, name: '8')
Dot.create(id: 9, name: '9')
Dot.create(id: 10, name: '10')
Dot.create(id: 11, name: '11')

Relation.delete_all
Relation.create(id: 1, dot_id: 1, left_index: 1, right_index: 22, level: 1)
Relation.create(id: 2, dot_id: 2, left_index: 2, right_index: 9, level: 2)
Relation.create(id: 3, dot_id: 3, left_index: 10, right_index: 15, level: 2)
Relation.create(id: 4, dot_id: 4, left_index: 16, right_index: 21, level: 2)
Relation.create(id: 5, dot_id: 5, left_index: 3, right_index: 4, level: 3)
Relation.create(id: 6, dot_id: 6, left_index: 5, right_index: 8, level: 3)
Relation.create(id: 7, dot_id: 7, left_index: 11, right_index: 14, level: 3)
Relation.create(id: 8, dot_id: 8, left_index: 17, right_index: 18, level: 3)
Relation.create(id: 9, dot_id: 9, left_index: 19, right_index: 20, level: 3)
Relation.create(id: 10, dot_id: 10, left_index: 6, right_index: 7, level: 4)
Relation.create(id: 11, dot_id: 11, left_index: 12, right_index: 13, level: 4)