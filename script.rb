require 'factory_bot'
require 'faker'

lines_count = 10
$separator = ";"
$content = ""
$header = ""
$output_file = "output.csv"
$locale = "pt-BR"

# Information to be randomly generate
class Customer
  attr_accessor :name, :gender, :age, :birthday, :cpf, :id
end

class Address
  attr_accessor :state, :city, :street, :zip_code
end

class Company
  attr_accessor :name, :industry, :cnpj
end

# It is possible to use diferents formats or information to generate the data
# Consult the Faker documentation for more options
FactoryBot.define do
  Faker::Config.locale = $locale
  factory :Customer do
    name { Faker::Name.name_with_middle }
    gender  { Faker::Gender.type }
    age { Faker::Number.between(from: 18, to: 130) }
    birthday { Faker::Date.between(from: '1930-01-01', to: Date.today) }
    cpf { Faker::IDNumber.brazilian_citizen_number}
    id { Faker::Alphanumeric.alphanumeric(number: 10) }
  end

  factory :Address do
    state { Faker::Address.state }
    city { Faker::Address.city }
    street { Faker::Address.street_address }
    zip_code { Faker::Address.zip_code }
  end

  factory :Company do
    name { Faker::Company.name }
    industry { Faker::Company.type }
    cnpj { Faker::Company.brazilian_company_number }
  end
end

# Define the header structure of output file
def header_build
  header = "customer name" + $separator + "gender" + $separator + "age" + $separator + "birthday" + $separator + "cpf" + $separator + "id" + $separator
  header +=  "state"+ $separator + "city "+ $separator + "street" +  $separator + "zip_code" + $separator
  header += "company name" + $separator + "industry" + $separator + "cnpj"
  $header = header
end

# Define the content structure of output file
def content_build (lines)
  content = "\n"

  for i in 1..lines
    customer = FactoryBot.build(:Customer)
    address = FactoryBot.build(:Address)
    company = FactoryBot.build(:Company)
    
    content += customer.name + $separator + customer.gender + $separator + customer.age.to_s + $separator + customer.birthday.to_s + $separator + customer.cpf.to_s + $separator + customer.id + $separator
    content += address.state + $separator + address.city + $separator + address.street +  $separator + address.zip_code + $separator
    content += company.name + $separator + company.industry + $separator + company.cnpj
    content += "\n"
  end

  $content += content
end

# Write the output file
def write_file
  File.open($output_file, "w") { |f| f.write $header }
  File.write($output_file, $content, mode: "a") 
end

header_build
content_build lines_count
write_file
