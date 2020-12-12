require 'minitest/autorun'
require 'pry'
require './day_01/part_1.rb'

class Part1Test < Minitest::Test

  def test_compute_2020
    list = IO.readlines("./day_01/input.txt")

    answer = Compute2020.new.perform(list)

    assert_equal(482811, answer)
  end

end