#!/usr/bin/ruby
require 'rubygems'
require 'yaml'
require 'csv'

require 'yaml2csv/hash_extensions'
Yaml2csv.extend_hash

module Yaml2csv
  # Convert a string containing YAML data to a CSV string
  def self.yaml2csv(yamldata, options = {})
    options = {:field_separator => ','}.merge(options)
    hash = YAML::load(yamldata)
    CSV.generate(:col_sep => options[:field_separator]) do |csv|
      hash.to_enum(:walk).each do |path, key, value|
        strvalue = value.is_a?(String) ? value : value.inspect
        csv << [path.join("/"), key, strvalue]
      end
    end
  end
  
  # Convert a string containing CSV values to a YAML string
  def self.csv2yaml(csvdata, options = {})
    options = {:field_separator => ','}.merge(options)
    rows = CSV.parse(csvdata, :col_sep => options[:field_separator])
    walk_array = rows.map do |strpath, key, value| 
      [strpath.split("/").map(&:to_s), key.to_s, value.to_s]
    end
    Hash.unwalk_from_array(walk_array).to_yaml
  end  
end
