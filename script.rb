require 'factory_bot'
require 'faker'

# Parameters to run the script
rows = 10
@content = ""
@delimiter = ";"
locale = 'pt-BR'
output_file = 'output.csv'

# Information to be randomly generate
# Define attributes to Customer object
class Customer
  attr_accessor :name, :gender, :age, :birthday, :cpf, :id
end

# Define attributes to Customer Address object
class Address
  attr_accessor :state, :city, :street, :zip_code
end

# Define attributes to Customer Company object
class Company
  attr_accessor :name, :industry, :cnpj
end

# It is possible to use diferents formats or information to generate the data
# Consult the Faker documentation for more options
Faker::Config.locale = locale

FactoryBot.define do
  factory :Customer do
    name { Faker::Name.name_with_middle }
    gender { Faker::Gender.type }
    age { Faker::Number.between(from: 18, to: 130) }
    birthday { Faker::Date.between(from: '1930-01-01', to: Date.today) }
    cpf { Faker::IDNumber.brazilian_citizen_number }
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
  header = "customer name" + @delimiter + "gender" + @delimiter
  header += "age" + @delimiter + "birthday" + @delimiter + "cpf" + @delimiter + "id" + @delimiter
  header += "state" + @delimiter + "city" + @delimiter + "street" + @delimiter + "zip_code" + @delimiter
  header += "company name" + @delimiter + "industry" + @delimiter + "cnpj"
  header
end

# Define the content structure of output file
def content_build(rows)
  content = "\n"

  (1..rows).each do
    customer = FactoryBot.build(:Customer)
    address = FactoryBot.build(:Address)
    company = FactoryBot.build(:Company)

    content += customer.name + @delimiter + customer.gender + @delimiter
    content += customer.age.to_s + @delimiter + customer.birthday.to_s + @delimiter
    content += customer.cpf.to_s + @delimiter + customer.id + @delimiter
    content += address.state + @delimiter + address.city + @delimiter
    content += address.street + @delimiter + address.zip_code + @delimiter
    content += company.name + @delimiter + company.industry + @delimiter + company.cnpj
    content += "\n"
  end

  @content += content
end

# Write the output file
def write_file(file_name)
  File.open(file_name, 'w') { |f| f.write header_build }
  File.write(file_name, @content, mode: 'a')
end

content_build(rows)
write_file(output_file)
