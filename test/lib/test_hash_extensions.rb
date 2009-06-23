#!/usr/bin/ruby
require 'test/unit'
require File.dirname(__FILE__) + '/../../lib/hash_extensions'

EXAMPLE_HASH = {
  "a" => {
    "b" => 3,
    "c" => 5,
  },
  "d" => 7,
}
    
EXAMPLE_ARY = [
  [["a"], "b", 3], 
  [["a"], "c", 5], 
  [[], "d", 7],
]

class TestHashExtensions < Test::Unit::TestCase 
  def test_store_path
    assert_equal({1 => 2, 3 => {4 => 5}}, \
      {1 => 2}.merge_path([3, 4], 5))      
    assert_equal({1 => 2, 3 => {4 => 5, 5 => 50}}, \
      {1 => 2, 3 => {5 => 50}}.merge_path([3, 4], 5))      
  end

  def test_walk(path=[], &block)
    assert_equal EXAMPLE_ARY, EXAMPLE_HASH.to_enum(:walk).to_a
  end
  
  def test_unwalk_from_array
    assert_equal EXAMPLE_HASH, Hash.unwalk_from_array(EXAMPLE_ARY)
  end
end
