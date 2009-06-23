#!/usr/bin/ruby
require 'rubygems'
require 'optparse'
require 'ostruct'

require 'lib/yaml2csv'

BANNER = "Usage: #{File.basename(__FILE__)} [options] INPUTFILE
    
YAML <-> CSV conversions. Output to standard output.

$ yaml2csv file.yml
$ yaml2csv --field-separator=';' --csv2yaml file.csv"

def read_file_or_stdin(path)
  path == "-" ? STDIN.read : File.read(path)
end

default_options = {
  "fs" => ",",
  "reverse" => false,
}
options = OpenStruct.new(default_options)
OptionParser.new do |opts|
  opts.banner = BANNER
  opts.on("-f", "--field-separator CHAR", "CSV Field Separator") do |fs|  
    options.fs = fs
  end
  opts.on("-r", "--csv2yaml", "Convert CSV file to YAML") do   
    options.reverse = true
  end
end.parse!(ARGV)

fileinput, = ARGV
unless fileinput
  STDERR.puts(BANNER)
  Process.exit 1
end

input = read_file_or_stdin(fileinput)
output = unless options.reverse
  YAML::yaml2csv(input, :field_separator => options.fs)
else
  YAML::csv2yaml(input)
end
puts output
