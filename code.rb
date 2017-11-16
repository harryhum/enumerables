module Enumerable
    def my_each
        i = 0
        while i < self.size
            yield(self[i])
            i += 1
        end
        self
    end

    def my_each_with_index
        i = 0
        while i < self.size
            yield(self[i], i)
            i += 1
        end
        self
    end  

    def my_select
        array = []
        self.my_each {|i| array << i if yield(i)} 
        puts array.inspect
    end

    def my_all?
        status = true
        self.my_each {|i| status = false if not yield(i)}
        puts status
    end

    def my_any?
        status = false
        self.my_each {|i| status = true if yield(i)}
        puts status
    end

    def my_none?
        status = true
        self.my_each {|i| status = false if yield(i)}
        puts status
    end

    def my_count
        count = 0
        if block_given?
            self.my_each {|i| count +=1 if yield(i)}
        else
            self.my_each {|i| count += 1}
        end
        puts count
    end

    def my_map(proc = nil)
        array = []
        if block_given?
            self.my_each {|i| array << yield(i)}
        elsif proc
            self.my_each {|i| array << proc.call(i)}
        else
            self.my_each {|i| array << i}
        end
        puts array.inspect
    end

    def my_inject
        i = 0
        while i < self.size - 1
            self[i+1] = yield(self[i], self[i+1])
            i += 1
        end
        puts self[self.size - 1]
    end
end

def multiply_els(array)
    array.my_inject {|product, n| product * n}
end

negatize = Proc.new {|n| n * -1}

[1, 2, 3].my_each {|n| puts n}
["shark", "dolphin", "whale"].my_each_with_index {|animal, index| puts animal if index%2 == 0}
[4, 8, 12, 16, 20].my_select {|n| n > 10}
['ant', 'bear', 'cat'].my_all? {|word| word.length >= 3}
['ant', 'bear', 'cat'].my_any? {|word| word.length >= 5}
['ant', 'bear', 'cat'].my_none? {|word| word.length >= 4}
[1, 2, 4, 2].my_count {|n| n%2 == 0}
[1, 2, 3, 4].my_map {'cat'}
[1, 2, 3, 4].my_inject {|product, n| product * n}
multiply_els([2, 4, 5])
[1, 2, 3, 4].my_map(negatize)