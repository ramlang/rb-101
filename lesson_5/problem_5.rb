# Given this nested Hash
munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}
# figure out the total age of just the male members of the family.

# my_answer =>
total = munsters["Herman"]["age"] + munsters["Grandpa"]["age"] + munsters["Eddie"]["age"]

# my_answer =>
sum = 0
munsters.each do |key, value|
  sum += munsters[key]["age"] if value.value?("male")
end


# correct_answer =>
total_male_age = 0
munsters.each_value do |details|
  total_male_age += details["age"] if details["gender"] == "male"
end

total_male_age # => 444

# In this example, we need to access two values from each inner hash. Since we're not referencing the key (each family member's name) from the key-value pairs in the outer hash, we can use Hash#each_value with a single block parameter.