require 'logger'

class Queue

  def initialize(max_size)
    @queue = []
    @max_size = max_size
    log_file = File.new("log/queue.log", "w+")
    @logger = Logger.new(log_file)
  end
  
  def enqueue(item)
    if size < @max_size
      @queue.unshift(item)
      @logger.info("Queued a message - enqueue operation，current buffer size: #{size}")
    else
      puts "The max_size of poller has been reached,poller will exit."
      exit
    end
    
  end

  def dequeue
    @queue.pop
    @logger.info("Queued a message - dequeue operation，current buffer size: #{size}")
  end

  def empty?
    @queue.empty?
  end

  def size
    @queue.length
  end

  def  to_s
    @queue.to_s
  end
end

queue = Queue.new(41)

for i in 1..41 do
  queue.enqueue(i)
end

i = 1
while queue.size > 2
  if i < 3
    queue.enqueue(queue.dequeue)
    i += 1
  else
    queue.dequeue
    i = 1
  end
end

puts queue.to_s
