# Given this previously seen family hash, print out the name, age and gender of each family member:
munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

# (Name) is a (age)-year-old (male or female).

# my_answer =>
munsters.each do |name, details|
  puts "#{name} os a #{details["age"]}-year-old #{details["gender"]}."
end


# example_of_answer =>
munsters.each_pair do |name, details|
  puts "#{name} is a #{details['age']} year old #{details['gender']}"
end
