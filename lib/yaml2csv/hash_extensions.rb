module Yaml2csv
  module HashExtensions
    # Merge a hash with a (keys_path, value)
    #
    #   hash = {1=>2}
    #   hash.merge_path([3,4], 5) #=> {1=>2, 3=>{4=>5}}
    #   
    def merge_path(keys, value)
       keys[0...-1].inject(self) do |result, key|
        result[key] ||= {}
      end[keys[-1]] = value
      self
    end

    # Walk a hash yielding [path, key, value] triplets
    #
    #   hash = {
    #     "a" => {
    #       "b" => 3,
    #       "c" => 5,
    #     },
    #     "d" => 7,
    #   }
    #  
    #   hash.to_enum(:walk).to_a
    #   # => [
    #   #     [[["a"], "b", 3], 
    #   #     [["a"], "c", 5], 
    #   #     [[], "d", 7]
    #   #   ]
    #
    def walk(path=[], &block)
      self.each do |key, value|
        if value.is_a?(Hash)
          value.walk(path + [key], &block)
        else
          yield [path, key, value]
        end
      end
    end
  end  

  module HashClassExtensions
    # Reverse a Hash#walk array output
    #
    def unwalk_from_array(ary)
      ary.inject({}) do |output, (path, key, value)|
        output.merge_path(path+[key], value)
      end 
    end
  end
  
  def self.extend_hash(obj = Hash)
    obj.send(:include, Yaml2csv::HashExtensions)
    obj.send(:extend, Yaml2csv::HashClassExtensions)
  end
end
