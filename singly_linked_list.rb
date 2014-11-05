class SinglyLinkedList
  Node = Struct.new(:data, :next)

  def initialize
    @head = nil
    @count = 0
  end
  
  def add(item)
    node = Node.new(item, nil)
    node.next = @head if @head
    @head = node
    @count += 1
  end

  def find(item)
    node = @head
    while node
      return node if node.data == item
      node = node.next
    end
  end

  def insert(insert_location, insert_item)
    insert_location_node = find(insert_location)
    if insert_location_node
      node = Node.new(insert_item, insert_location_node.next)
      insert_location_node.next = node
      @count += 1
    else
      puts "insert location is not exist."
    end
  end

  def remove(item)
    to_be_removed_node = find(item)
    if to_be_removed_node
      if size == 1
        @head = nil
      elsif to_be_removed_node = @head
        @head = @head.next
      else
        node = @head
        while node.next
          if to_be_removed_node.data == node.next.data
            node.next = to_be_removed_node.next
          end
          node = node.next
        end
      end
      @count -= 1
    else
      puts "remove item is not exist."
    end
  end

  def size
    @count
  end

  def to_s
    node = @head
    list_string = node.data.to_s
    while node.next
      list_string += " -> #{node.next.data}"
      node = node.next
    end
    list_string
  end
end

singly_list = SinglyLinkedList.new
singly_list.add(1)
singly_list.add(2)
singly_list.insert(2,3)
puts singly_list # "2 -> 3 -> 1"
singly_list.remove(2)
puts singly_list # "3 -> 1"
singly_list.remove(1)
puts singly_list # "3"
puts singly_list.size