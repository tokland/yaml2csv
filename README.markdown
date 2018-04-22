# Yaml2Csv

Transform YAML file into CSV and backwards. CSV files contain triplets [path, key, value]. For example:

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

Only YAML files containing hashes and string values are supported (that includes most I18n YML files). Non-string values (i.e. arrays, booleans) are allowed, but will be treated as strings and its format will be lost.

## Usage 

### As Ruby module

    require 'yaml2csv'
    Yaml2csv::yaml2csv(string, :field_separator => ',')
    Yaml2csv::csv2yaml(string)

### From command line

Convert file.yaml into CSV format:

    $ yaml2csv file.yml

Convert file.csv into YAML format (using ',' as field separator)

    $ yaml2csv -f"," -r file.csv
