class SortedList
  def initialize
    @items = []
  end
  
  def add(item)
    return @items << item if @items.empty?

    position = 0
    while position < @items.length
      return @items.insert(position, item) if @items[position] > item
      position += 1
    end

    @items.push(item) #如果不是以上两种情况，那么item是就最大的，因此要插入到数组的最后一位
  end

  def remove(item)
    @items.delete(item)
  end

  def to_s
    @items.to_s
  end
end

list = SortedList.new
list.add(3)
list.add(8)
list.add(4)
list.add(9)
list.add(1)
puts list    #=> [1, 3, 4, 8, 9]