*** Settings ***
Resource    ../resources/common.resource

Suite Setup   Suite Setup E2E

*** Test Cases ***
Open New Account and Verify in Account Overview
    [Documentation]    This test logs in with a valid user, opens a new account from an existing one,
    ...                captures the ID of the new account displayed on the screen, and verifies that the new account appears in the accounts list.
    [Tags]    ui    e2e    accounts    smoke
    [Teardown]    Run Keyword And Ignore Error    Logout User
    Login User
    Open New Account   
    Select Account Type    account_type=${ACCOUNT_TYPE_SAVINGS}
    Select Source Account
    Create New Account
    ${account_id}=    Capture Account ID
    Account Overview
    Verify New Account Appears In Overview        ${account_id}

Account Transfer Between Accounts
    [Documentation]    This test logs in with a valid user, opens a new account, and performs a fund transfer between accounts.
    [Tags]    ui    e2e    transfer    smoke     regression
    [Teardown]    Run Keyword And Ignore Error    Logout User
    Login User
    Open New Account   
    Select Account Type    account_type=${ACCOUNT_TYPE_CHECKING}
    Select Source Account
    Create New Account
    Click       ${TRANSFER_FUNDS_LINK}
    ${money}=    Enter Transfer Amount    100
    ${from_account}=    Check From Account
    Select Options By    ${FROM_ACCOUNT_SELECT}    value    ${from_account}    
    ${to_account}=      Check To Account    ${from_account}
    Select Options By    ${TO_ACCOUNT_SELECT}      value    ${to_account}
    Transfer Funds    ${money}    ${from_account}    ${to_account}
    Account Overview
    
Open New Account and Verify Via API
    [Documentation]    This test opens a new account in the UI and verifies via API that the new account appears in the customer's accounts list.
    [Tags]    ui    e2e    api    accounts    regression
    [Teardown]    Run Keyword And Ignore Error    Logout User
    Login User
    Login With API to Get User ID
    Open New Account   
    Select Account Type    account_type=${ACCOUNT_TYPE_SAVINGS}
    Select Source Account
    Create New Account
    ${account_id}=    Capture Account ID

    Create Session For API

    ${accounts}=    Get Customer Accounts
    ${account_ids}=    Create List
    FOR    ${account}    IN    @{accounts}
        ${id}=    Get From Dictionary    ${account}    id
        ${id}=    Convert To String    ${id}
        Append To List    ${account_ids}    ${id}
    END

    ${account_id}=    Convert To String    ${account_id}
    List Should Contain Value    ${account_ids}    ${account_id}




