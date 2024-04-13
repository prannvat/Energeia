from flask import Flask, request, jsonify
from web3 import Web3
w3 = Web3(Web3.HTTPProvider('https://rpc-evm-sidechain.xrpl.org'))  # replace with your sidechain's RP

from Components.mod1 import get_account, get_account_info
import requests

import requests

app = Flask(__name__)



@app.route('/get_standby_account', methods=['POST'])
def get_standby_account():
    seed = request.json['seed']
    new_wallet = get_account(seed)
    return jsonify(classic_address=new_wallet.classic_address, seed=new_wallet.seed)

@app.route('/get_standby_info')
def get_standby_info():
    standby_address = '0x4b86Dcd16171FbD4a5e3F55f335E6D75b7EaAf5A'  # replace with your standby address
    balance = w3.eth.get_balance(standby_address)
    balance_in_ether = Web3.from_wei(balance, 'ether')
    return jsonify({'address': standby_address, 'balance': balance_in_ether})


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


@app.route("/")
def hello_world():
    return "<p>Hello, World!</p>"



if __name__ == '__main__':
    app.run(debug=True)