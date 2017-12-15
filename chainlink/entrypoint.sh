#!/bin/bash

# Has this node been initialised?
FILE=/initialise.out
if [ ! -f $FILE ]; then
    # Confirm to create coordinator keys
    bundle exec
    echo "Y" | rake oracle:initialize > $FILE
    cat $FILE

    # Output the key-pairs to a file also on the host
    grep 'SECRET:' $FILE > "/host/keypair"
    grep 'KEY:' $FILE >> "/host/keypair"
fi

# Start the node
foreman start