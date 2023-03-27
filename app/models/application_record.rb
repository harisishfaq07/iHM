class ApplicationRecord < ActiveRecord::Base
  require 'rest-client'
  primary_abstract_class

#   def self.countries
#     @countries = []
#     url = "https://restcountries.com/v3.1/all"
#     @list = RestClient.get(url)
#     @res = JSON.parse(@list)
#     @res.each do |c|
#         @countries.push(c["name"]["common"])
#     end
#     return @countries
# end
end
