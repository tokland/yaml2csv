#!/usr/bin/ruby
require 'test/unit'
require File.dirname(__FILE__) + '/../../lib/yaml2csv'

YAML_EXAMPLE =<<-EOF
---
path1:
  path11:
    key11a: value11a
    key11b: value11b
  path12:
    path121:
      key121a: value121a
path2:
  key2a: value2a
EOF

CSV_EXAMPLE1 = <<-EOF
path1/path11,key11a,value11a
path1/path11,key11b,value11b
path1/path12/path121,key121a,value121a
path2,key2a,value2a
EOF

class TextYamlExtensions < Test::Unit::TestCase
  def test_yaml2csv
    assert_equal CSV_EXAMPLE1, YAML::yaml2csv(YAML_EXAMPLE)    
  end
    
  def test_csv2yaml
    assert_equal YAML_EXAMPLE, YAML::csv2yaml(CSV_EXAMPLE1)    
  end      
end
