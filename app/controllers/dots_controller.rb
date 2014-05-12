class DotsController < ApplicationController
  def index
	@dots_hash=initialization
  end

  def new
  	@dots_hash=initialization
  end

def create
  	name=params[:name]
  	parent=params[:parent].to_i

    if parent==0
    @ok_relation=true

    dot=Dot.new
    dot.name=name

    relation = Relation.new
    relation.left_index=1
    relation.right_index = 2
    relation.level = 1

    dot.relation=relation
    @ok_dot=dot.save
    else #->

  	#render :json => parent;return

  	@dots_hash=initialization

  	#берем свойства родителя

  	parent_preference=@dots_hash.select {|x| x[:id]==parent} #родитель
  	parent_preference_level=parent_preference[0][:level]

  	#добавляем элемент в наш хеш элементов
  	#id не определен
  	@dots_hash.each.with_index do |e, i| 
    if e[:id] == parent
    @position=i+1
    end
  	end

  	#закидываем в хеш созданную точку
  	@dots_hash.insert(@position,{id: -1, level: parent_preference_level+1, name: name, visible: false})

  	#проставляем left и right
  	left_right_initialization(@dots_hash)

  	#записываем в бд
  	dot_new=@dots_hash.select {|x| x[:id]==-1} 
  


  dot=Dot.new
	dot.name=dot_new[0][:name]

	relation = Relation.new
	relation.left_index=dot_new[0][:left_index]
	relation.right_index = dot_new[0][:right_index]
	relation.level = dot_new[0][:level]

	dot.relation=relation
	@ok_dot=dot.save

	if @ok_dot==true
  	@dots_hash.each do |dot_|
  	if dot_[:id]!=-1
  	relation = Relation.find(dot_[:id])
	relation.left_index = dot_[:left_index]
	relation.right_index = dot_[:right_index]
	@ok_relation=relation.save
	end
  	end
  	end

    end #->

  	if @ok_relation==true and @ok_dot==true
  	redirect_to :root
  	else
  	redirect_to :back, notice: 'blank the name, or other error'
  	end


end

def left_right_initialization(dots_hash)
    index=0
	  @left_index=1 #определяем начальн. значения 
  	@right_index=1

  	
  	@mas_right_other=[] #right_index массив, дабы повыставлять right точкам

  	#расставляем left_index right_index
  	dots_hash.each do |dot|

  	if index==0 
  	dot[:left_index]=1
  	dot[:right_index]=dots_hash.length*2
  	end

  	
  	if defined? @previous_dot
  	#1

  	if dot[:level]>@previous_dot[:level]
    @left_index+=1
  	dot[:left_index]=@left_index

  	@mas_right_other.push(index-1) if index>1
	
  	end

  	#2
  	if dot[:level]==@previous_dot[:level]
  	@left_index+=2
	dot[:left_index]=@left_index

	@right_index=@previous_dot[:left_index]+1
	#----------------------
	@previous_dot[:right_index]=@right_index

  	end

    #3 поднимаемся
    if dot[:level]<@previous_dot[:level]
    @left_index=@left_index+@previous_dot[:level]
	dot[:left_index]=@left_index
	
	@right_index=@previous_dot[:left_index]+1
    #----------------------
	@previous_dot[:right_index]= @right_index


	@mas_right_other=@mas_right_other.reverse
	@mas_right_other.each.with_index do |e|

	@right_index+=1
	dots_hash[e][:right_index]=@right_index

	end
	#обнуляем точки подъема
	@mas_right_other=[]
  	end

  	if index==dots_hash.length-1 

  	@right_index=dot[:left_index]+1	

    #---------------------
    dot[:right_index]=@right_index
	@mas_right_other=@mas_right_other.reverse
	@mas_right_other.each.with_index do |e|

	@right_index+=1
	dots_hash[e][:right_index]=@right_index
	end

  	end

  	end

  	#предыдущая точка
  	@previous_dot=dot
  	index+=1
  	end

dots_hash
end

def delete_show

end

def delete
	parent=params[:parent].to_i

	dots_hash=initialization

	dots_hash.each.with_index do |e, i| 
    if e[:id] == parent
    @position=i
    end
  	end

  	#удалили родителя (хотя мож лучше не нужно)
	dots_hash.delete_at(@position)

	#render json: @position;return


  	m=open_close_dot(parent)

  	#удаляем все точки с бд
  	m[1].each do |dot| 

  	d=Dot.find(dot)
  	d.destroy
  	end

  	#удаляем саму точку с бд
  	d=Dot.find(parent)
  	d.destroy

  	#удаляем с хеша сперва все эти точки
  	dots_hash.delete_if { |a| m[1].include?(a[:id]) }

  	#перерисовываем left_index right_index в хеше
  	dots_hash=left_right_initialization(dots_hash)

  	#меняем бд
  	dots_hash.each do |dot_| 	
  	relation = Relation.find(dot_[:id])
	  relation.left_index = dot_[:left_index]
	  relation.right_index = dot_[:right_index]
	  @ok_relation=relation.save
  	end

    #render json: @m
  	redirect_to :root

	#render json: dots_hash.to_s
end


  	#render :json => @dots_hash


end
