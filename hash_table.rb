class HashTable
  def initialize(size)
    @size = size
    @slots = Array.new(size)
    @values = Array.new(size)
  end
  
  def put(key, value)
    resize if (@slots.compact.length.to_f / @size) > 0.7

    hash_value = hash_function(key)

    loop do
      if @slots[hash_value].nil?
        @slots[hash_value] = key
        @values[hash_value] = value
        return value
      elsif @slots[hash_value] == key
        @values[hash_value] = value
        return value
      else
        hash_value = refresh(hash_value)
      end
    end
  end

  def get(key)
    hash_value = hash_function(key)

    loop do
      if @slots[hash_value] == key
        return @values[hash_value]
      else
        hash_value = refresh(hash_value)
      end
    end
  end

  def hash_function(key)
    key.chars.map(&:ord).reduce(&:+) % @size
  end

  def refresh(hash_value)
    (hash_value + 1) % @size
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
    @slots.compact.length
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
hash_table["abc"] = 234
puts hash_table.size
hash_table.put("xyz", 456)
puts hash_table.size
hash_table.put("acb", 789)

puts hash_table["abc"] #=> 234
puts hash_table["xyz"] #=> 456
puts hash_table.get("acb") #=> 789