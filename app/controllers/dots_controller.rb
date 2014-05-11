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

  	@dots_hash.insert(@position,{id: -1, level: parent_preference_level+1})

    index=0
	@left_index=1 #определяем начальн. значения 
  	@right_index=1

  	@mas_right_down=[] #right_index нижние
  	@mas_right_other=[] #right_index остальные
  	@mas_right_up_position=[] #точки подъема
  	@mas_in=[]

  	@dots_hash.each do |dot|

  	if index==0 
  	dot[:left_index]=1
  	dot[:right_index]=@dots_hash.length*2
  	end

  	
  	if defined? @previous_dot
  	#1

  	if dot[:level]>@previous_dot[:level]
    @left_index+=1
  	dot[:left_index]=@left_index
  	#puts index.to_s + ' dot[:id]=' + dot[:id].to_s+ ' @previous_dot[:id]='+@previous_dot[:id].to_s
  	#@mas_in.push([@previous_dot[:id], index-1])
  	@mas_right_other.push(index-1) if index>1
  	#@mas_right_up.push(dot[:id])	
  	end

  	#2
  	if dot[:level]==@previous_dot[:level]
  	@left_index+=2
	dot[:left_index]=@left_index

	@right_index=@previous_dot[:left_index]+1
	puts ' right_index='+ @right_index.to_s+ ' @previous_dot[:id]='+@previous_dot[:id].to_s + ' @previous_dot[:left_index]='+@previous_dot[:left_index].to_s
	#----------------------
	@previous_dot[:right_index]=@right_index
	#@right_index=@left_index+1
	#dot[:right_index]=@right_index


	@mas_right_down.push(@previous_dot[:id])
	#@right_index=@left_index+1
	#dot[:right_index]=@right_index
  	end

    #3 поднимаемся
    if dot[:level]<@previous_dot[:level]
    @left_index=@left_index+@previous_dot[:level]
	dot[:left_index]=@left_index
	

	@mas_right_up_position.push(@previous_dot[:id])
	@right_index=@previous_dot[:left_index]+1
	puts ' right_index='+ @right_index.to_s+ ' @previous_dot[:id]='+@previous_dot[:id].to_s + ' @previous_dot[:left_index]='+@previous_dot[:left_index].to_s
    #----------------------
	@previous_dot[:right_index]= @right_index
	#dot[:right_index]='123'

	#puts @right_index
	@mas_right_other=@mas_right_other.reverse
	@mas_right_other.each.with_index do |e|
	#if e[1]>0
	@right_index+=1
	puts '@right_index='+@right_index.to_s
	@dots_hash[e][:right_index]=@right_index
	#puts e[0]
	#@dots_hash[e[1]][:right_index]=@right_index
	end
	#====-<

	#end
	#@mas_in=[]


	#@mas_right_up_position.push(@previous_dot[:id])
	#@mas_right_up=[]
	#@mas_right_other
	@mas_right_other=[]
  	end

  	if index==@dots_hash.length-1 #возможно нужно исправить
  	@mas_right_down.push(dot[:id])

  	@right_index=dot[:left_index]+1	
	puts ' right_index='+ @right_index.to_s+ ' dot[:id]='+dot[:id].to_s + ' dot[:left_index]='+dot[:left_index].to_s

    #---------------------
    dot[:right_index]=@right_index
	@mas_right_other=@mas_right_other.reverse
	@mas_right_other.each.with_index do |e|
	#if e[1]>0
	@right_index+=1
	puts '@right_index='+@right_index.to_s
	@dots_hash[e][:right_index]=@right_index
	#puts e[0]
	#@dots_hash[e[1]][:right_index]=@right_index
	end

  	end

  	end

  	#предыдущая точка
  	@previous_dot=dot
  	index+=1
  	end

  	#@mas_right_down=[] #right_index нижние
  	#@mas_right_other=[] #right_index остальные
  	#@mas_right_up_position=[] 

  	#@mas_right_up + последний элемент который
  	#полюбому туда-же относится
  	#@mas_right_down
  	#@dots_hash
  	#@mas_in
  	puts '----'
  	puts @mas_right_down #right_index нижние
  	puts '----'
  	puts @mas_right_other #right_index остальные
  	puts '----'
  	puts @mas_right_up_position
  	render :json => @dots_hash

  	


  end

end
