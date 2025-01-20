# Testing Guide for TokenFactory Module

## Prerequisites
1. Start your blockchain:
```bash
ignite chain serve
```

2. Open a new terminal for executing commands

## Test Scenarios

### 1. Creating a New Denom

Create a denom named "uignite":
```bash
~/go/bin/tokenfactoryd tx tokenfactory create-denom \
$(~/go/bin/tokenfactoryd keys show alice -a) \
uignite \
"My denom" \
IGNITE \
6 \
"some/url" \
1000000000 \
true \
--from alice
```

### 2. Querying the Denom

Check the list of denoms:
```bash
~/go/bin/tokenfactoryd query tokenfactory list-denom
```

### 3. Updating the Denom

Modify the uignite denom:
```bash
~/go/bin/tokenfactoryd tx tokenfactory update-denom \
$(~/go/bin/tokenfactoryd keys show alice -a) \
uignite \
"Updated Description" \
"newurl" \
2000000000 \
false \
--from alice
```

Verify the changes:
```bash
~/go/bin/tokenfactoryd query tokenfactory list-denom
```

### 4. Minting and Sending Tokens

Mint and send tokens to a recipient:
```bash
~/go/bin/tokenfactoryd tx tokenfactory mint-and-send-tokens \
$(~/go/bin/tokenfactoryd keys show alice -a) \
uignite \
1200 \
cosmos16x46rxvtkmgph6jnkqs80tzlzk6wpy6ftrgh6t \
--from alice
```

Check recipient's balance:
```bash
~/go/bin/tokenfactoryd query bank balances cosmos16x46rxvtkmgph6jnkqs80tzlzk6wpy6ftrgh6t
```

Verify updated supply:
```bash
~/go/bin/tokenfactoryd query tokenfactory list-denom
```

### 5. Transferring Ownership

Transfer ownership of uignite:
```bash
~/go/bin/tokenfactoryd tx tokenfactory update-owner \
$(~/go/bin/tokenfactoryd keys show alice -a) \
uignite \
cosmos16x46rxvtkmgph6jnkqs80tzlzk6wpy6ftrgh6t \
--from alice
```

Confirm ownership change:
```bash
~/go/bin/tokenfactoryd query tokenfactory list-denom
```

### 6. Testing Ownership Restrictions

Try minting with previous owner (should fail):
```bash
~/go/bin/tokenfactoryd tx tokenfactory mint-and-send-tokens \
$(~/go/bin/tokenfactoryd keys show alice -a) \
uignite \
1200 \
cosmos16x46rxvtkmgph6jnkqs80tzlzk6wpy6ftrgh6t \
--from alice
```

## Notes
- All commands use the full path to tokenfactoryd binary (`~/go/bin/tokenfactoryd`)
- Make sure your blockchain is running before executing these commands
- The owner address is automatically retrieved using `$(~/go/bin/tokenfactoryd keys show alice -a)`
- All transactions require the `--from alice` flag to specify the signer
