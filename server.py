from flask import Flask, request, jsonify
from flask import Flask, request, jsonify
from xrpl.wallet import Wallet
from xrpl.models.transactions import Payment
from xrpl.models.amounts import XRPAmount
from xrpl.clients import JsonRpcClient
from xrpl.transaction import send_reliable_submission
from xrpl.models.requests.account_info import AccountInfo
from xrpl.wallet import Wallet
from xrpl.wallet import generate_faucet_wallet

import requests

app = Flask(__name__)

JSON_RPC_URL = "https://s.altnet.rippletest.net:51234/"
client = JsonRpcClient(JSON_RPC_URL)

@app.route('/get_standby_account', methods=['POST'])
def get_standby_account():
    seed = request.json['seed']
    new_wallet = get_account(seed)
    return jsonify(classic_address=new_wallet.classic_address, seed=new_wallet.seed)

@app.route('/get_standby_info', methods=['GET'])
def get_standby_info_fixed():
    standby_seed = 'rPNQ1n1oTFGjQxveCgE7j9guAAeQDyeozU'
    accountInfo = get_account_info(standby_seed)
    return jsonify(accountInfo)

@app.route('/get_seed_info/<standby_seed>', methods=['GET'])
def get_standby_info(standby_seed):
    accountInfo = get_account_info(standby_seed)
    return jsonify(accountInfo)

@app.route('/send_xrp/<seed>/<amount>/<destination>', methods=['POST'])
def send_xrp(seed, amount, destination):
    # Create a wallet from the seed
    wallet = Wallet(seed, 0)

    # Define the payment
    payment = Payment(
        account=wallet.classic_address,
        amount=XRPAmount(amount),
        destination=destination,
    )

    # Send the payment
    response = send_reliable_submission(client, payment, wallet)

    return jsonify(response.result)



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