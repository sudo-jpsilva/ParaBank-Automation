*** Settings ***
Library    Collections
Resource    ../resources/common.resource
Resource    ../resources/pages/account_page.resource
Resource    ../resources/api.resource

Suite Setup   Suite Setup E2E

*** Test Cases ***
Open New Account and Verify in Account Overview
    [Documentation]    This test logs in with a valid user, opens a new account from an existing one,
    ...                captures the ID of the new account displayed on the screen, and verifies that the new account appears in the accounts list.
    [Tags]    smoke
    Login User
    Open New Account   
    Select Options Type Of Account  account_type=${account_type_savings}
    Select At Least One Acount To Transfer From
    Create New Account
    ${account_id}=    Capture Account ID
    Account Overview
    Check if the new account is present on the table of accounts    ${account_id}
    Logout User

Account Transfer Between Accounts
    [Documentation]    This test logs in with a valid user, opens a new account, and performs a fund transfer between accounts.
    [Tags]    smoke
    Login User
    Open New Account   
    Select Options Type Of Account  account_type=${account_type_checking}
    Select At Least One Acount To Transfer From
    Create New Account
    #Transfer Funds
    Click       xpath=//*[@id="leftPanel"]/ul/li[3]/a
    ${money}=    Amount to Transfer    100
    ${from_account}=    Check From Account
    Select Options By    id=fromAccountId    value    ${from_account}    
    ${to_account}=      Check To Account    ${from_account}
    Select Options By    id=toAccountId      value    ${to_account}
    Transfer Funds    ${money}    ${from_account}    ${to_account}
    Account Overview
    Sleep    5s
    Logout User

    #Missing The confirmation of the trasnfer between accounts, values
    



