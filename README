= Yaml2Csv

Transform YAML file into CSV and backwards. CSV files contain
triplets [path, key, value]. For example:

    path1:
      path11:
        key11a: value11a
        key11b: value11b
      path12:
        path121:
          key121a: value121a
    path2:
      key2a: value2a
  
Will be converted into:

    path1/path11,key11a,value11a
    path1/path11,key11b,value11b
    path1/path12/path121,key121a,value121a
    path2,key2a,value2a

Only YAML files containing hashes and string values are supported 
(for example the typical I18n YML files). Non-string values (i.e. arrays,
booleans) will be treated as strings.

== Dependencies

ya2yaml: http://github.com/ptb/ya2yaml/tree/master

== Usage 

=== as Ruby module

    require 'lib/yaml_extensions'
    YAML::yaml2csv(string, :field_separator => ';')
    YAML::csv2yaml(string)

=== from command line

Convert YAML file to CSV:

    $ yaml2csv_conv file.yml

Convert CSV file to YAML (using ';' as field separator

    $ yaml2csv_conv --field-separator=';' --csv2yaml file.csv"
