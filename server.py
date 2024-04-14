from eth_account import Account
from flask import Flask, request, jsonify
from web3 import Web3
w3 = Web3(Web3.HTTPProvider('https://rpc-evm-sidechain.xrpl.org'))  # replace with your sidechain's RP

from Components.mod1 import get_account, get_account_info
import requests

import requests

app = Flask(__name__)



# @app.route('/get_standby_account', methods=['POST'])
# def get_standby_account():
#     seed = request.json['seed']
#     new_wallet = get_account(seed)
#     return jsonify(classic_address=new_wallet.classic_address, seed=new_wallet.seed)

# @app.route('/get_standby_info')
# def get_standby_info():
#     standby_address = '0x8c092962c808a774FEA973C54b907e5396A7e509'  # replace with your standby address
#     balance = w3.eth.get_balance(standby_address)
#     balance_in_ether = Web3.from_wei(balance, 'ether')
#     return jsonify({'address': standby_address, 'balance': balance_in_ether})


# @app.route('/get_seed_info/<standby_seed>', methods=['GET'])
# def get_standby_info(standby_seed):
#     accountInfo = get_account_info(standby_seed)
#     return jsonify(accountInfo)

# @app.route('/send_xrp/<seed>/<amount>/<destination>', methods=['POST'])
# def send_xrp(seed, amount, destination):
#     # Create a wallet from the seed
#     wallet = Wallet(seed, 0)

#     # Define the payment
#     payment = Payment(
#         account=wallet.classic_address,
#         amount=XRPAmount(amount),
#         destination=destination,
#     )

#     # Send the payment
#     response = send_reliable_submission(client, payment, wallet)

#     return jsonify(response.result)



# @app.route('/get_account/<seed>', methods=['GET'])
# def get_account_info(seed):
#     wallet = get_account(seed)
#     client = JsonRpcClient("https://s.altnet.rippletest.net:51234")  # Use the appropriate URL for your XRPL network
#     account_info = AccountInfo(
#         account=wallet.classic_address,
#         ledger_index="validated",
#         strict=True,
#         queue=True,
#     )
#     response = client.request(account_info)
#     if 'account_data' in response.result:
#         balance = response.result["account_data"]["Balance"]
#     else:
#         return jsonify({'error': 'Account data not found'}), 404

#     return jsonify({
#         'public_key': wallet.public_key,
#         'private_key': wallet.private_key,
#         'classic_address': wallet.classic_address,
#         'seed': wallet.seed,
#         'balance': balance
#     })

@app.route('/get_balance/<address>', methods=['GET'])
def get_balance(address):
    w3 = Web3(Web3.HTTPProvider('https://rpc-evm-sidechain.xrpl.org'))  # replace with your sidechain's RPC URL
    balance = w3.eth.get_balance(address)
    balance_in_ether = w3.from_wei(balance, 'ether')
    return jsonify({'address': address, 'balance': balance_in_ether})


@app.route('/send_ether', methods=['POST'])
def send_ether():
    # private_key = 'e06230b93ab4d91411ea61e07be1a7f46af712102ce61a5adef7a0f25877ad14' 
     # replace with your actual private key
    private_key = 'c3bc734c9b6de94c33910553a79250228e32ace0f9aaabdbf79b7b09bfc0b13a'
    # destination_address = '0x697FF21B2e1b66E2b35A8f336B3CBcF9E5256ebe'  # replace with the actual destination address
    destination_address = '0x8c092962c808a774FEA973C54b907e5396A7e509'
    amount_in_ether = 100 # replace with the actual amount

    w3 = Web3(Web3.HTTPProvider('https://rpc-evm-sidechain.xrpl.org'))  # replace with your sidechain's RPC URL
    account = Account.from_key(private_key)
    amount_in_wei = w3.to_wei(amount_in_ether, 'ether')
    nonce = w3.eth.get_transaction_count(account.address)
    transaction = {
        'to': destination_address,
        'value': amount_in_wei,
        'gas': 2000000,
        'gasPrice': w3.to_wei('50', 'gwei'),
        'nonce': nonce,
        'chainId': 1440002  # replace with your sidechain's chain ID
    }
    signed_transaction = w3.eth.account.sign_transaction(transaction, account.key)
    tx_hash = w3.eth.send_raw_transaction(signed_transaction.rawTransaction)
    return tx_hash.hex()

@app.route("/")
def hello_world():
    return "<p>Hello, World!</p>"




if __name__ == '__main__':
    app.run(debug=True)