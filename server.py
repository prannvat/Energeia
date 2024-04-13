from flask import Flask, request, jsonify
    
from Components.mod1 import get_account, get_account_info
import requests

app = Flask(__name__)

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

@app.route('/get_standby_info/<standby_seed>', methods=['GET'])
def get_standby_info(standby_seed):
    accountInfo = get_account_info(standby_seed)
    return jsonify(accountInfo)


@app.route("/")
def hello_world():
    return "<p>Hello, World!</p>"



if __name__ == '__main__':
    app.run(debug=True)