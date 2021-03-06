require 'pry'
class PrintQueue
  def initialize
    @tasks = []
  end

  def enqueue(task)
    return @tasks << task if @tasks.empty?

    position = 0
    while position < @tasks.size
      return @tasks.insert(position, task) if task.pages < @tasks[position].pages
      position += 1
    end

    @tasks.push(task)
  end

  def dequeue
    @tasks.shift
  end

  def size
    @tasks.size
  end

  def empty?
    size == 0
  end

  # def pages_in_queue
  #   @tasks.reduce(0) {|total_pages, task| total_pages + task.pages}
  # end
end

class Task
  attr_accessor :pages, :starting_time
  def initialize(pages, starting_time)
    @pages = pages
    @starting_time = starting_time
  end
end

class Printer
  attr_reader :current_task

  def initialize(ppm)
    @ppm = ppm
  end

  def idle?
    @current_task.nil? || @current_task.pages <= 0
  end

  def take_task(task)
    @current_task = task
  end

  def busy?
    !idle?
  end

  def print_page
    @current_task.pages = @current_task.pages - (@ppm / 60.0)
  end
end

def simulate!(ppm)
  @print_queue = PrintQueue.new
  @printer = Printer.new(ppm)
  total_tasks_enqueue = 0
  total_pages_enqueue = 0
  current_second = 0
  waiting_times = []
  while current_second < 28800 do
    if rand(1..12) == 1
      task = Task.new(rand(1..10), current_second)
      @print_queue.enqueue(task)
      total_tasks_enqueue += 1
      total_pages_enqueue += task.pages
    end
    if @printer.idle? && !@print_queue.empty?
      @printer.take_task(@print_queue.dequeue)
    end
    if @printer.busy?
      @printer.print_page
      if @printer.idle?
        waiting_times << (current_second - @printer.current_task.starting_time)
      end
    end
    current_second += 1
  end
  average_waiting_time = waiting_times.reduce(&:+) / waiting_times.size
  meet_requirements = average_waiting_time <= 120 ? "Yes" : "No" #等待时间小等于120秒满足要求
  puts "---------The simulated result of the #{ppm} ppm printer----------"
  puts "Meet the office requirements:#{meet_requirements}"
  puts "average waiting time is #{average_waiting_time}, #{total_tasks_enqueue} tasks in queue, #{total_pages_enqueue} total pages"
end

10.times {simulate!(60)}
10.times {simulate!(30)}
