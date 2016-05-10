require_relative '../lang/errors'

class LinkedList
  def initialize(first = nil)
    @size = 0
    @first = nil

    # If there is already a first value
    @first = ListItem.new(first) if first != nil
    @size = 1 if first != nil
  end

  def append(value)
    if @first == nil
      # List is empty here
      @first = ListItem.new(value)
    else
      # Append to exisiting list
      item = @first
      while item.next != nil
        item = item.next
      end
      # Found the last item -> append
      item.set_next ListItem.new(value)
    end
    @size += 1
  end

  def first
    @first
  end

  def size
    @size
  end
end

class ListItem
  def initialize(value)
    @value = value
    @next = nil
  end

  def next
    @next
  end

  def set_next(next_item)
    @next = next_item
  end

  def value
    @value
  end
end
