from brownie import network, chain
import pytest
from scripts.helpful_scripts import (
    LOCAL_BLOCKCHAIN_ENVIRONMENTS,
    get_account,
    get_accounts
)
from scripts.deploy import deploy


def test_vesting():
    # deploy the contracts
    # fastforward time
    # check release function
    # Arrange
    if network.show_active() not in LOCAL_BLOCKCHAIN_ENVIRONMENTS:
        pytest.skip("Only for local testing")
    # Act
    account = get_account()
    accounts = get_accounts()
    tkn,tlock = deploy()
    # timetravel
    chain.sleep(65)
    tx_release = tlock.release({'from':account})
    tx_release.wait(1)
    # assert
    for acc in get_accounts():
        assert tkn.balanceOf(acc) == tlock._releaseSupply()