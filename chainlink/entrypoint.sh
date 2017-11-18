# Confirm to create coordinator keys
bundle exec
echo "Y" | rake oracle:initialize > "/initialise.out"
cat /initialise.out

# Output the key-pairs to a file also on the host
grep 'SECRET:' "/initialise.out" > "/host/keypair"
grep 'KEY:' "/initialise.out" >> "/host/keypair"

# Start the node
foreman start