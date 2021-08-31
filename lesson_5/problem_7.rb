# Given this code, what would be the final values of a and b? Try to work this out without running the code.
a = 2
b = [5, 8]
arr = [a, b] # => [2, [5, 8]]

arr[0] += 2 # => [4, [5, 8]]
arr[1][0] -= a # => [4, [1, 8]]

# my_answer =>
# a = 4
# b = [1, 8]


# correct_answer =>
# a => 2
# b => [3, 8]

# The value of variable a did not change because we are not changing variable a it is the arr at index 0 we are changing, this means that it will be pointing at a new object (4) instead of variable a like before. Basically instead of the arr containing variable a (2) at arr[0] is now contains 4. But when we modify arr at index 1 index 0 we are modifying variable b ([5, 8]) because variable b is an array. This means variable b will become [3, 8] and so arr is now equal to [4, [3, 8]]
