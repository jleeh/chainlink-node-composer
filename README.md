# Chainlink Node Composer
Docker compose image for a Chainlink node. This includes all the required dependancies and config to get a node running with very minimal effort. This image will work out of the box with no set-up required.

## Table of Contents
- [Dependencies](#dependencies)
- [Usage](#usage)
- [License](#license)

## Dependencies
- [Docker] (https://www.docker.com/)
- [Docker Compose] (https://docs.docker.com/compose/) (Bundled with later Docker versions)

## Usage
Clone the git repo, then run the following commands:

``` bash
# Change to repo directory
cd chainlink-node-composer

# Start the Docker containers in the background
docker-compose up -d
```

That's it!

To verify your node is working properly, wait around 10-60 seconds depending on your PC speed, then run the following command:

``` bash
# Ask CL Node to get the block height from Ethereum Client
docker exec -it $(docker ps -q --filter ancestor=smartcontract/chainlink) rails runner "puts Ethereum::Client.new.current_block_height"
```

If that command returns a number, for example `4564112`, then it works!

For further information on how to interact with your node, or for Chainlink in general, read the following documentation:
- Documentation (https://chainlink-docs.smartcontract.com)
- Github (https://github.com/smartcontractkit/chainlink)

## License
[Smart-Oracle License](LICENSE.md)