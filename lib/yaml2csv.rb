#!/usr/bin/ruby
require 'rubygems'
require 'yaml'
require 'csv'
require 'ya2yaml'

require File.dirname(__FILE__) + '/hash_extensions'

module YAML
  # Convert a string containing YAML data to a CSV string
  #
  def YAML.yaml2csv(yamldata, options = {})
    hash = YAML::load(yamldata)
    output = ""
    csv_writer = CSV::BasicWriter.new(output, options[:field_separator])
    hash.to_enum(:walk).each do |path, key, value|
      strvalue = value.is_a?(String) ? value : value.inspect
      csv_writer << [path.join("/"), key, strvalue]
    end
    output
  end
  
  # Convert a string containing CSV values to a YAML string
  def YAML.csv2yaml(csvdata, options = {})
    rows = CSV::parse(csvdata, options[:field_separator])
    walk_array = rows.map do |strpath, key, value| 
      [strpath.split("/").map(&:to_s), key.to_s, value.to_s]
    end
    hash = Hash.unwalk_from_array(walk_array)
    $KCODE = "UTF8"
    # Remove any trailing spaces inserted by String#to_yaml
    hash.ya2yaml.gsub(/\s+$/, '') + "\n"
  end  
end
