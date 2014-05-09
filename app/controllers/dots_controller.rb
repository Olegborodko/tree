class DotsController < ApplicationController
  def index
  	dots=Dot.all
  	relations=Relation.all
  	@dots_hash = []  #массив из точек
    #@m=dots.find_by(id: 2)[:name]
    #@m=relations[0].dot

  	relations.each do |r|
  	@dots_hash.push({id: r.id, name: r.dot[:name], left_index: r.left_index, right_index: r.right_index, visible: (r.level)==1 ? true : false, level: r.level })
  	end
    
  	@dots_hash=@dots_hash.sort_by{ |elem| elem[:left_index] }  #сортируем для отображения
    session[:dots_hash]=@dots_hash


  end

end
