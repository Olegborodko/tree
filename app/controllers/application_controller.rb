class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def initialization()
  	dots=Dot.all
  	relations=Relation.all
  	@dots_hash = []  #массив из точек
    #@m=dots.find_by(id: 2)[:name]
    #@m=relations[0].dot

  	relations.each do |r|
  	@dots_hash.push({id: r.id, name: r.dot[:name], left_index: r.left_index, right_index: r.right_index, visible: (r.level)==1 ? true : false, level: r.level })
  	end
    
    #session[:dots_hash]=@dots_hash
  	@dots_hash=@dots_hash.sort_by{ |elem| elem[:left_index] }  #сортируем для отображения
    
  end
  helper_method :initialization
#точки которые закрыть и открыть
  def open_close_dot(id_open)

  	dot_click=initialization.select {|x| x[:id]==id_open} #нажатая точка
  	dot_left_index=dot_click[0][:left_index]
  	dot_right_index=dot_click[0][:right_index]
  	dot_level=dot_click[0][:level]

  	mas_dot_close=[] #точки которые нужно закрыть
  	mas_dot_open=[] #точки которые нужно открыть
    mas_dot_contains=[] #точки которые содержат ещё элементы

  	initialization.each do |dot|
  		if dot_left_index<dot[:left_index] and
  		   dot_right_index>dot[:right_index]

           mas_dot_close.push(dot[:id])

           if dot[:right_index]-dot[:left_index]!=1 and dot_left_index==1
           mas_dot_contains.push(dot[:id])
           end

  		   if dot_level==dot[:level]-1
  		   mas_dot_open.push(dot[:id])	
  		   end
  		end	

  	end
  	return mas_dot_open, mas_dot_close, id_open, mas_dot_contains
  end
  helper_method :open_close_dot

end
