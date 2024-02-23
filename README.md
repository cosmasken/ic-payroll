![](./media/header.png)

# IC-PAYROLL

IC-PAYROLL is an experimental app to demonstrate a real world use case for [ckBTC](https://internetcomputer.org/ckbtc/) on the Internet Computer. It is a simple Payroll that allows users to accept  and make payments using ckBTC payments.

The Internet Computer [integrates directly with the Bitcoin network](https://internetcomputer.org/docs/current/developer-docs/integrations/bitcoin/). This allows canisters on the Internet Computer to receive, hold, and send Bitcoin, all directly with transactions on the Bitcoin network. Chain-key Bitcoin (ckBTC) is an ICRC-1-compliant token that is backed 1:1 by Bitcoin held 100% on the IC mainnet.

For deeper understanding of the ICP < > BTC integration, see the IC wiki article on [Bitcoin integration](https://wiki.internetcomputer.org/wiki/Bitcoin_Integration).

## Features

- **CRUD Users**: Users logs in with their Internet Identity and adds users they want to make payments to.
- **Send tokens**: Users can send ckBTC tokens to other users.
- **Receive tokens**: Users can receive ckBTC tokens from other users.
- **Bulk transfers**: Users can make bulk transfers to multiple users.
- **Schedule payments**: Users can schedule payments to be made at a future date.
- **Receive notifications**: Users can choose to receive notifications by email or SMS when a payment is received. This uses the [HTTP Outcall](https://internetcomputer.org/docs/current/developer-docs/integrations/https-outcalls/) feature of the Internet Computer.
- **Transaction history**: Users can view a list of transactions made to the store.

## Architecture

### Backend

The backend is written in Motoko and consist of one canister, `backend`. It exposes the following public methods:

- `getUser` - returns the store configuration for a given principal.
- `getInvoice` - returns the funding address for a particular user.
- `updateUser` - updates the store configuration for a given principal.
- `transferFromSubAccountToCanister` - transfers funds to the canister's account.
- `transferFromSubAccountToSubAccount` - transfers funds to the another user's account.
- `runpayroll` - bulk transfers to multiple users/address with various amounts.
- `send_notifications` - sends notifications to users when a payment is received.
- `getFundingAddress` - returns the funding address for a particular user.
- `getFundingBalance` - returns the funding balance for a particular user.
- `getTradingAddress` - returns the trading address for a particular user.
- `getTradingBalance` - returns the trading balance for a particular user.
- `setCourierApiKey` - sets the Courier API key used to send email and SMS notifications. Only the canister controller can call this method.

In addition to the public methods, the canister uses a [timer](https://internetcomputer.org/docs/current/motoko/main/timers/) to monitor ledger transactions. When a new transaction is found that matches a configured store – depending on the store settings – the canister will send a notification either by email or SMS.


### Frontend

The frontend is written in Javascript/Vite/Vue/TailwindCSS. Users authenticate using the Internet Identity to access their store.

The frontend interacts with the following IC canisters:

- `backend` - to fetch and update user information as well as make transfers.
- `ckbtc ledger` - to send ckBTC to other users.
- `ckbtc index` - to fetch transaction history.
- `internet identity` - to authenticate users.

# Local deployment

## Prerequisites

- [x] Install the [IC SDK](https://internetcomputer.org/docs/current/developer-docs/setup/install/index.mdx).
- [x] Install [Node.js](https://nodejs.org/en/).

### Use the package,,json scripts to  automate the whole process 
```bash
npm run start && npm run dev
```

### This will setup the project and get it running. you can then login and start transacting

### OR Step 1: Start a local instance of the Internet Computer

```bash
dfx start --clean --background
```



### Step 2: Deploy the Internet Identity canister

Integration with the [Internet Identity](https://internetcomputer.org/internet-identity/) allows store owners to securely setup and manage their store. The Internet Identity canister is already deployed on the IC mainnet. For local development, you need to deploy it to your local instance of the IC.

```bash
dfx deploy --network local internet_identity
```

### Step 3: Save current principal as a variable

The principal will be used when deploying the ledger canister.

```bash
export OWNER=$(dfx identity get-principal)
```

### Step 3: Deploy the ckBTC ledger canister

The responsibilities of the ledger canister is to keep track of token balances and handle token transfers.

The ckBTC ledger canister is already deployed on the IC mainnet. ckBTC implements the [ICRC-2](https://internetcomputer.org/docs/current/developer-docs/integrations/icrc-2/) token standard. For local development, we deploy the ledger for an ICRC-2 token mimicking the mainnet setup.

Take a moment to read the details of the call we are making below. Not only are we deploying the ledger canister, we are also:

- Deploying the canister to the same canister ID as the mainnet ledger canister. This is to make it easier to switch between local and mainnet deployments.
- Naming the token `Local ckBTC / LCKBTC`
- Setting the owner principal to the principal we saved in the previous step.
- Minting 100_000_000_000 tokens to the owner principal.
- Setting the transfer fee to 10 LCKBTC.

```bash
dfx deploy --network local --specified-id mxzaz-hqaaa-aaaar-qaada-cai ckbtc_ledger --argument '
  (variant {
    Init = record {
      token_name = "Local ckBTC";
      token_symbol = "LCKBTC";
      minting_account = record {
        owner = principal "'${OWNER}'";
      };
      initial_balances = vec {
        record {
          record {
            owner = principal "'${OWNER}'";
          };
          100_000_000_000;
        };
      };
      metadata = vec {};
      feature_flags = opt record{icrc2 = true };
      transfer_fee = 10;
      archive_options = record {
        trigger_threshold = 2000;
        num_blocks_to_archive = 1000;
        controller_id = principal "'${OWNER}'";
      }
    }
  })
'
```

### Step 4: Deploy the index canister

The index canister syncs the ledger transactions and indexes them by account.

```bash
dfx deploy --network local icrc1_index --argument '
  record {
   ledger_id = (principal "mxzaz-hqaaa-aaaar-qaada-cai");
  }
'
```

### Step 5: Deploy the backend canister

The backend canister manages the user configuration and sends notifications when a payment is received.

The `--argument '(0)'` argument is used to initialize the canister with `startBlock` set to 0. This is used to tell the canister to start monitoring the ledger from block 0. When deploying to the IC mainnet, this should be set to the current block height to prevent the canister from processing old transactions.

```bash
dfx deploy --network local backend --argument '(0)'
```

### Step 6: Configure the backend canister

The backend uses [Courier](https://courier.com/) to send email and SMS notifications. If you want to enable notifications, you need to sign up for a Courier account and and create and API key. Then issue the following command:

```bash
dfx canister --network local call backend setCourierApiKey "pk_prod_..."
```
### Step 7: Build and run the frontend

Run npm to install dependencies and start the frontend. The frontend will be available at http://localhost:3000.

```bash
npm install
npm run dev
```

### Step 8: Generate did files
```bash
dfx generate backend
```

This generates the did files for the backend canister. You can find the generated files in the `./src/declarations/backend` directory.This is what allows you to call the backend canister from the frontend.

### Step 9: Login and start transacting
Go to http://localhost:3000 and login with the Internet Identity

### Step 10: Get funds
```bash
npm run mint
```

Enter the amount of ckBTC you want to mint and the principal you want to mint to. The principal is the Internet Identity principal of the user you want to mint to. You can find the principal by logging in to the frontend and copying the principal from the URL.Also send some funds to the canister so you can receive funds when you request test tokens

### Step 11: Start transacting
You can now start transacting with the app. You can send funds to other users and receive funds from other users.

Note that you need to refresh manually to see the updated balance after a transaction.
