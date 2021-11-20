from scripts.helpful_scripts import (
    get_account,
    get_accounts
    
)
from brownie import Token, TokenTimelock, network, config, web3
import time
 

def deploy():
    account = get_account()
    accounts = get_accounts()
    # deploy token
    tkn = Token.deploy({'from':account})
    # deploy timelock contract
    tlock = TokenTimelock.deploy(tkn,accounts,int(time.time())+60,{'from':account})
    tx = tkn.transfer(tlock,1e26,{'from':account})
    tx.wait(1)
    print("Deployed!")
    return tkn,tlock
    


def main():
    deploy()