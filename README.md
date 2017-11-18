# Chainlink Node Composer
Docker compose image for a Chainlink node. This includes all the required dependancies and config to get a node running with very minimal effort. This image will work out of the box with no set-up required.

**IMPORTANT:** If you will be using this node for anything other than local testing, follow the steps in [Configuration](#configuration).

## Table of Contents
- [Dependencies](#dependencies)
- [Usage](#usage)
- [Configuration](#configuration)
- [License](#license)

## Dependencies
- Docker (https://www.docker.com/)
- Docker Compose (https://docs.docker.com/compose/) (Bundled with later Docker versions)

## Usage
Clone the git repo, then run the following commands:

``` bash
# Change to repo directory
cd chainlink-node-composer

# Build the chainlink container
docker-compose build

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

Once you've verified your node, open the `chainlink-node-composer` folder and you should see a file called `keypair.txt`. It should contain something like:
```
KEY: <KEY HERE>
SECRET: <KEY HERE>
``` 

This is your coordinator key-pair used for authenticating into your own node.

## Configuration
Even though this compose image works out of the box, it is recommended to edit the environment files. If you're planning to use this compose image for a main-net node, it is critical that you follow the below guide.

### Chainlink Node
To begin with, the `chainlink.env` file is pre-populated with the following:
``` bash
# Postgres Connection
DATABASE_URL=postgresql://postgres:password@postgres:5432/chainlink?encoding=utf8&pool=5&timeout=5000

# Coordinator Keys Password
PRIVATE_KEY_PASSWORD="P@ssw0rd"

# Ethereum Client Properties
ETHEREUM_URL=http://ethereum:8545
ETHEREUM_EXPLORER_URL=https://testnet.etherscan.io

# Node Notification Email
NOTIFICATION_EMAIL=test@test.com
```

To expand on the properties listed above:
- `DATABASE_URL`: This is the postgres connection string. By default it points to the docker container which runs postgres. The password needs to align with `POSTGRES_PASSWORD` in `postgres.env`.
- `PRIVATE_KEY_PASSWORD`: This will be your password for your key-pair files stored in the database (table: key_pairs). **This is critical to change when running on main-net.**
- `ETHEREUM_URL`: The ethereum client URL. This points to the geth instance running within the docker container.
- `ETHEREUM_EXPLORER_URL`: The ethereum explorer URL. Currently points to the eth testnet.
- `NOTIFICATION_EMAIL`: Email address to send node notifications to.

A full list of Chainlink environment variables can be found [here](https://github.com/thodges-gh/ChainLink-Node/blob/master/EnvironmentVariables.md)

### Postgres
In the `postgres.env` file, you'll find the following populated:
``` bash
POSTGRES_PASSWORD=password
```
- `POSTGRES_PASSWORD`: The password which the postgres user is given when the DB is created. If you change this password, you also need to change the password found in `DATABASE_URL` in `chainlink.env`.

### Special Thanks
- @thodges-gh: This image was set-up with the information found in https://github.com/thodges-gh/ChainLink-Node

## Donate
If you found this useful and would like to donate:
- ETH: 0x58f251EAdEF20c6aB734bF166EF7d61a79B12df4

## Futher Reading
For further information on how to interact with your node, or for Chainlink in general, read the following documentation:
- Documentation (https://chainlink-docs.smartcontract.com)
- Github (https://github.com/smartcontractkit/chainlink)

## License
[Smart-Oracle License](LICENSE.md)