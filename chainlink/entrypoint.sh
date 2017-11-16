# Confirm to create coordinator keys
bundle exec
echo "Y" | rake oracle:initialize > "/initialise.out"

# Output the key-pairs to a file also on the host
grep 'SECRET:' "/initialise.out" > "/host/keypair.txt"
grep 'KEY:' "/initialise.out" >> "/host/keypair.txt"

# Start the node
foreman start