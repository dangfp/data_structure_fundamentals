require 'pry'
class SinglyLinkedList
  Node = Struct.new(:data, :next)

  def initialize
    @head = nil
    @current_node = nil
    @count = 0
  end
  
  def add(item)
    node = Node.new(item, nil)
    node.next = @head if @head
    @head = node
    @current_node = node
    @count += 1
  end

  def find(item)
    node = @head
    while node
      if node.data == item
        @current_node = node
        return true
      elsif node.next == nil
        return false
      end
      node = node.next
    end
  end

  def insert(item)
    if @current_node
      node = Node.new(item, @current_node.next)
      @current_node.next = node
      @count += 1
    end
  end

  def remove
    # binding.pry
    if size == 1
      initialize
      return true
    elsif @head == @current_node
      @head = @current_node.next
      @current_node = @head
      @count -= 1
      return true
    else
      node = @head
      while node
        if @current_node.data == node.next.data
          node.next = @current_node.next
          @current_node = node
          @count -= 1
          return true
        end
        node = node.next
      end
    end
  end

  def size
    @count
  end

  def to_s
    node = @head
    while node
      current_node = node.data
      node = node.next
      puts current_node
    end
  end
end

singly_list = SinglyLinkedList.new
singly_list.add(1)
singly_list.add(2)
singly_list.insert(3)
singly_list.to_s
singly_list.find(3)
singly_list.insert(0)
singly_list.remove
singly_list.to_s
singly_list.remove
singly_list.to_s
puts singly_list.size