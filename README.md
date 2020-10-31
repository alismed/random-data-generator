## Random Data Generator

A script using [Faker](https://github.com/faker-ruby/faker) and [Factory Bot](https://github.com/thoughtbot/factory_bot) to generate random data in `csv` file format.

### Requirements
It is necessary [Ruby](https://www.ruby-lang.org/en/)

### Setup
Clone this repository and execute the comando bellow to install the dependencies Gems:
```
bundle install
```

### Instructions
The classes `Customer`, `Company` and `Address`defined in the script especified the information present in the output file. These are example and could be modified or expanded.

The methods `header_build` and `content_build` especified the estructure the output file. Don't forget to match the header and content values.

The variable `lines_count` define how many lines the output file will have.

The variable global `$separator` define the character separator.

### Run
Execute the comando bellow to generate the output file:
```
ruby ./script.rb
```