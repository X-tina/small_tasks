class Array

  def self_map(&block)
    # self.each { |i| block.call(i) if block_given? }
    self.self_reduce([]) {|res,i| res << block.call(i)}
  end

  def self_select(&block)
    # res = []
    # self.each { |i| res << i if block.call(i) }
    # res
    # self.self_reduce([]) {|res,i| res << i if block.call(i)}
    self.self_reduce([]) {|res,i| block.call(i) ? res << i : res}
  end

  def self_count(&bclock)
    # res = 0
    # self.each { |i| res += 1 }
    # res
    self.self_reduce(0) {|res,i| res += 1 }
  end

  def self_all?(&block)
    # res = []
    # self.each { |i| res << block.call(i) }
    # res.reduce(:&)
    self.self_reduce([]) {|res,i| res << block.call(i) }.reduce(:&)
  end

  def self_any?(&block)
    self_count > 0
  end

  def self_flatten
    res = []
    self.map {|e| e.is_a?(Fixnum) ? res << e : e.map {|i| res << i}}
    res
  end

  def self_group_by(&block)
    res = {}
    self.map { |i| (res[block.call(i)] ||= []) << i }
    res
  end

  def sort_odd_even
    self.group_by {|i| i%2 == 0}.values.flatten
  end

  def self_reverse
    self.reduce([]) {|res,i| res.unshift(i)}
  end

  #Sum of array index
  def sum_index
    Hash[self.map.with_index.to_a].values.reduce(:+)
  end
end

module Enumerable
  #array.self_reduce {|res,i| res += i}
  #array.self_reduce(1) {|res,i| res *= i}
  def self_reduce(res=0, &block)
    self.each do |i|
      res = block.call(res, i)
    end
    res
  end

  def self_detect(&block)
    # self.each { |i| break i if block.call(i) }
    self.self_reduce(nil) {|res,i| block.call(i) ? i : res }
  end
end

  #Частота появления
  #input = ['a', 'b', 'c']
  def func(*input)
    input.empty? ? nil : Hash[input.group_by {|k| k}.map {|k,v| [k, v.size]}]
  end

  def palindrome? string
    string = string.downcase.gsub(/\W/, '')
    string == string.chars.reduce('') {|a,b| b+a}
  end

 #Возведение в степень
  def power(x, n)
    if n == 0
      1
    elsif n < 0
      nil
    else
      x*power(x, n-1)
    end
  end

  #Split String by Upcase letter "TestString" => "test_string"
  def split_camel string
    string.to_s.split(/(?=[A-Z])/).map(&:downcase).join('_')
  end
