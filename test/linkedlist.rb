require_relative '../util/linked_list'

module LinkedListTest
    def self.test
      list = LinkedList.new
      raise "Size should be 0 is #{list.size}" unless list.size == 0
      list.append(42)
      raise "Size should be 1, is #{list.size}" unless list.size == 1
      raise "First should be 42, is #{list.first.value}" unless list.first.value == 42
      list.append(1337)
      raise "Size should be 2, is #{list.size}" unless list.size == 2
      raise "Second should be 1337, is #{list.first.value}" unless list.first.next.value == 1337
      list.append(23)
      raise "Size should be 3, is #{list.size}" unless list.size == 3
      raise "Third should be 23, is #{list.first.value}" unless list.first.next.next.value == 23
    end
end
