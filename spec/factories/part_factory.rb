Factory.define :part do |f|
  f.name { Faker::Internet.domain_word }
end
