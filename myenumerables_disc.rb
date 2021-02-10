module Enumerable
  # each
  def my_each
    return enum_for(:each) unless block_given?
    for i in self
      yield i
    end
  end
  # my_each_with_index
  def my_each_with_index
    return enum_for(:each) unless block_given?
    myindex = 0
    for i in self
      yield i, myindex
      myindex += 1
    end
  end
  # my_select
  def my_select
    selected = []
    for i in self
      selected.push(i) if yield i
    end
    return selected
  end
  # my_all? ------------
  def my_all?

    self.my_each do |x|
      return false unless yield x
    end
    true
  end
  # my_any?
  # my_none?
  # my_count
  # my_map
  def my_map
    return self.dup unless block_given?
    retarr = []
    self.my_each do |x|
      retarr.push(yield (x))
    end
    retarr
  end
  # my_inject

end

exmaplearr = [4, 5, 6, 7]
exmaplearr.my_each{|x| puts x + 2}
newarr = exmaplearr.my_select{|num| num>5}
p newarr
maparr = exmaplearr.my_map
maparr2 = exmaplearr.my_map{|x| x**2}
p maparr
p maparr2
strings = %w[bacon orange apple]
if strings.all?{|str| str.length == 5}
  puts "yey"
end
