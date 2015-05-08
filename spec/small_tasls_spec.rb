require_relative '../small_tasks.rb' 
require 'yaml'

context "small_tasks.rb" do
  let(:array) { [1, 5, 8] }

  it { expect(array.class).to eq Array }

  describe "self_map function" do
    block = lambda {|i| i*2}

    it { expect(array.self_map(&block)).to match_array [2, 10, 16] }
    it { expect(array.self_map(&block)).to_not match_array array }
  end

  block = lambda {|i| i%2 == 0}

  describe "self_select function" do
    block = lambda {|i| i%2 == 0}

    it { expect(array.self_select(&block).class).to eq Array }
    it { expect(array.self_select(&block)).to match_array [8] }
    it { expect(array.self_select(&block)).to_not match_array [1, 5] }
    it { expect(array.self_select(&block)).to eq array.select(&block) }
  end

  describe "self_count" do
    it { expect(array.self_count.class).to eq Fixnum }
    it { expect(array.self_count).to eq array.count }
    it { expect(array.self_count).to_not eq (array.count + 1) }
  end

  describe "self_all?" do
  	it { expect(array.self_all?(&block).class).to eq FalseClass }
    it { expect(array.self_all?(&block)).to eq false }
    it { expect(array.self_all? {|k| k<100}).to eq true }
  end

  describe "self_any?" do
    it { expect(array.self_any?(&block).class).to eq TrueClass }
    it { expect([].self_any?.class).to eq FalseClass }
    it { expect(array.self_any?(&block)).to eq true }
  end

  describe "self_flatten" do
    let(:new_one) { [[1, 2], 3, [4], 5] }

    it { expect(new_one.self_flatten).to eq [1, 2, 3, 4, 5] }
    it { expect(new_one.self_flatten).to_not eq new_one }
  end

  describe "self_group_by" do
    it { expect(array.self_group_by(&block).class).to eq Hash }
    it { expect(array.self_group_by(&block).class).to_not eq Array }
    it { expect(array.self_group_by(&block)).to eq array.group_by(&block) }
  end
end