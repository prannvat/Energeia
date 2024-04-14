from eth_account import Account
from flask import Flask, request
from web3 import Web3

application = Flask(__name__)

@application.route("/",methods = ["POST"])
def send_ether():

    private_key = request.json["private_key"]  # replace with your actual private key
    destination_address = request.json['destination_address']  # replace with the actual destination address
    amount_in_ether = request.json['ether_amount']  # replace with the actual amount

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






if __name__ == "__main__":
    application.debug = True
    application.run()