# This function allows you to create unsorted lists of values of given length
# based on given ring.
def generate_list(scale:, length: 16, seed: rrand_i(1, 1000000))
  use_random_seed seed
  unsorted_list = []
  while unsorted_list.length < length
    n = scale.choose
    unsorted_list.push(n) unless unsorted_list.include?(n)
  end
  unsorted_list
end

# The default sorted function that will run if no other function is passed
DEFAULT_SORTED = Proc.new { |list, sort_name|
  puts "#{sort_name} sorted the list!"
  puts list
}
