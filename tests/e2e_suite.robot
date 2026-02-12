*** Settings ***
Library    Collections
Resource    ../resources/common.resource
Resource    ../resources/pages/account_page.resource

Suite Setup   Suite Setup E2E

*** Test Cases ***
Open New Account and Verify in Account Overview
    [Documentation]    This test logs in with a valid user, opens a new account from an existing one,
    ...                captures the ID of the new account displayed on the screen, and verifies that the new account appears in the accounts list.
    [Tags]    ui    e2e    accounts    smoke
    [Teardown]    Logout User
    Login User
    Open New Account   
    Select Account Type    account_type=${account_type_savings}
    Select Source Account
    Create New Account
    ${account_id}=    Capture Account ID
    Account Overview
    Verify New Account Appears In Overview        ${account_id}

Account Transfer Between Accounts
    [Documentation]    This test logs in with a valid user, opens a new account, and performs a fund transfer between accounts.
    [Tags]    ui    e2e    transfer    smoke     regression
    [Teardown]    Logout User
    Login User
    Open New Account   
    Select Account Type    account_type=${account_type_checking}
    Select Source Account
    Create New Account
    #Transfer Funds
    Click       xpath=//*[@id="leftPanel"]/ul/li[3]/a
    ${money}=    Enter Transfer Amount    100
    ${from_account}=    Check From Account
    Select Options By    id=fromAccountId    value    ${from_account}    
    ${to_account}=      Check To Account    ${from_account}
    Select Options By    id=toAccountId      value    ${to_account}
    Transfer Funds    ${money}    ${from_account}    ${to_account}
    Account Overview
    Sleep    5s

    #Missing The confirmation of the trasnfer between accounts, values
    



