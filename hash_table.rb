class HashTable
  def initialize(size)
    @size = size
    @slots = Array.new(size)
    @values = Array.new(size)
    @used_size = 0
  end
  
  def put(key, value)
    resize if (@used_size.to_f / @size) > 0.7

    index = hash_function(key)

    while @slots[index]
      if index == (@size - 1) #如果已到达数组最后一位，那么从头再开始
        index = 0
      else
        index += 1
      end
    end

    @slots[index] = key
    @values[index] = value
    @used_size += 1
  end

  def get(key)
    initial_index = hash_function(key)
    index = initial_index

    while @slots[index] #如果到达一个空桶，或者又回到初始位置，则说明没有关键字为Key的元素
      return @values[index] if @slots[index] == key

      if index == (@size - 1)
        index = 0
      else
        index += 1
      end

      break if index == initial_index #
    end
  end

  def hash_function(key)
    key.chars.map(&:ord).reduce(&:+) % @size
  end

  def [](key)
    get(key)
  end

  def []=(key, value)
    put(key, value)
  end

  def keys
    @slots
  end

  def values
    @values
  end

  def size
    @size
  end

  def resize
    @size *= 2

    temp_keys = @slots.compact
    temp_values = @values.compact
    @slots = Array.new(@size)
    @values = Array.new(@size)

    for i in 0...temp_keys.length
      put(temp_keys[i], temp_values[i])
    end
  end
end

hash_table = HashTable.new(1)
hash_table["abc"] = 123
puts hash_table.size
hash_table.put("xyz", 456)
puts hash_table.size
hash_table.put("acb", 789)

puts hash_table["abc"] #=> 123
puts hash_table["xyz"] #=> 456
puts hash_table.get("acb") #=> 789