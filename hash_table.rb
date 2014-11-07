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
    @values[@slots.index(key)]
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
    @slots.compact
  end

  def values
    @values.compact
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