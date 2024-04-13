import xrpl
from web3 import Web3
testnet_url = "https://s.devnet.rippletest.net:51234/"

from web3.auto import w3



def get_account(seed):
    """get_account"""
    client = xrpl.clients.JsonRpcClient(testnet_url)
    if (seed == ''):
        new_wallet = xrpl.wallet.generate_faucet_wallet(client)
    else:
        new_wallet = xrpl.wallet.Wallet.from_seed(seed)
    return new_wallet

def get_account_info(accountId):
    w3 = Web3(Web3.HTTPProvider('https://rpc-evm-sidechain.xrpl.org'))
    balance = w3.eth.get_balance(accountId)
    balance_in_ether = w3.fromWei(balance, 'ether')
    return {'balance': balance_in_ether}

def send_xrp(seed, amount, destination):
    sending_wallet = xrpl.wallet.Wallet.from_seed(seed)
    client = xrpl.clients.JsonRpcClient(testnet_url)
    payment = xrpl.models.transactions.Payment(
        account=sending_wallet.address,
        amount=xrpl.utils.xrp_to_drops(int(amount)),
        destination=destination,
    )
    try:	
        response = xrpl.transaction.submit_and_wait(payment, client, sending_wallet)	
    except xrpl.transaction.XRPLReliableSubmissionException as e:	
        response = f"Submit failed: {e}"

    return response

def send_ether(destination_address, amount_in_ether):
    w3 = Web3(Web3.HTTPProvider('https://rpc-evm-sidechain.xrpl.org/'))  # replace with your sidechain's RPC URL
    amount_in_wei = w3.toWei(amount_in_ether, 'ether')
    nonce = w3.eth.getTransactionCount(account.address)
    transaction = {
        'to': destination_address,
        'value': amount_in_wei,
        'gas': 2000000,
        'gasPrice': w3.toWei('50', 'gwei'),
        'nonce': nonce,
        'chainId': 1  # replace with your sidechain's chain ID
    }
    signed_transaction = w3.eth.account.signTransaction(transaction, account.privateKey)
    tx_hash = w3.eth.sendRawTransaction(signed_transaction.rawTransaction)
    return tx_hash.hex()
