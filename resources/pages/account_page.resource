*** Settings ***
Library     Browser
Library     Collections
Resource    ../variables.resource


*** Variables ***
# Navigation Links
${OPEN_ACCOUNT_LINK}            xpath=//*[@id="leftPanel"]/ul/li[1]/a
${ACCOUNTS_OVERVIEW_LINK}       xpath=//*[@id="leftPanel"]/ul/li[2]/a
${TRANSFER_FUNDS_LINK}          xpath=//*[@id="leftPanel"]/ul/li[3]/a

# Open Account Form
${ACCOUNT_TYPE_SELECT}          xpath=//*[@id="type"]
${FROM_ACCOUNT_SELECT}          id=fromAccountId
${TO_ACCOUNT_SELECT}            id=toAccountId
${SUBMIT_ACCOUNT_BUTTON}        xpath=//div[@id="openAccountForm"]//input[@type="button" and @value="Open New Account"]
${NEW_ACCOUNT_ID_LABEL}         xpath=//*[@id="newAccountId"]

# Account Overview
${ACCOUNTS_OVERVIEW_TITLE}      xpath=//h1[normalize-space()="Accounts Overview"]
${ACCOUNTS_TABLE}               css=#accountTable

# Transfer Funds Form
${TRANSFER_AMOUNT_FIELD}        //*[@id="amount"]
${TRANSFER_SUBMIT_BUTTON}       xpath=//*[@id="transferForm"]/div[2]/input


*** Keywords ***
Open New Account
    [Documentation]    Navigates to the Open New Account page.
    Click    ${OPEN_ACCOUNT_LINK}
    Wait For Elements State    text=What type of Account would you like to open?    visible    10s

Select Account Type
    [Documentation]    Selects the type of account to open.
    [Arguments]    ${account_type}=${ACCOUNT_TYPE_SAVINGS}
    Select Options By    ${ACCOUNT_TYPE_SELECT}    value    ${account_type}
    Wait For Elements State    ${FROM_ACCOUNT_SELECT}    visible    15s

Select Source Account
    [Documentation]    Selects a source account for transfers when opening a new account.
    Wait For Accounts To Load    ${FROM_ACCOUNT_SELECT}
    ${accounts}=    Get Select Options    ${FROM_ACCOUNT_SELECT}
    Log    Available accounts: ${accounts}
    ${from_account}=    Get From List    ${accounts}    0
    ${from_value}=    Get From Dictionary    ${from_account}    value
    Select Options By    ${FROM_ACCOUNT_SELECT}    value    ${from_value}
    RETURN    ${from_value}

Wait For Accounts To Load
    [Documentation]    Waits until a select element has at least one option loaded (retries up to 10s).
    [Arguments]    ${selector}
    FOR    ${i}    IN RANGE    20
        ${options}=    Get Select Options    ${selector}
        ${count}=    Get Length    ${options}
        IF    ${count} > 0    RETURN
        Sleep    500ms
    END
    Fail    Select element '${selector}' had no options after 10 seconds.

Create New Account
    [Documentation]    Clicks the button to create a new account.
    Click    ${SUBMIT_ACCOUNT_BUTTON}
    Wait For Elements State    ${NEW_ACCOUNT_ID_LABEL}    visible    10s

Capture Account ID
    [Documentation]    Captures the ID of the newly created account from the confirmation page.
    ${account_id}=    Get Text    ${NEW_ACCOUNT_ID_LABEL}
    Log    New Account ID: ${account_id}
    Should Not Be Empty    ${account_id}    New account ID was not created by the application.
    RETURN    ${account_id}

Account Overview
    [Documentation]    Navigates to the Account Overview page.
    Click    ${ACCOUNTS_OVERVIEW_LINK}
    Wait For Elements State    ${ACCOUNTS_OVERVIEW_TITLE}    visible    10s

Verify New Account Appears In Overview
    [Documentation]    Verifies that the newly created account appears in the accounts overview table.
    [Arguments]    ${account_id}
    Should Not Be Empty    ${account_id}    Account id argument is empty. Did Capture Account ID fail?
    Wait For Elements State    ${ACCOUNTS_TABLE} >> text=${account_id}    visible    10s
    Log    New account ${account_id} is present in the accounts overview.

Check From Account
    [Documentation]    Retrieves the value of the selected "from account" option.
    Wait For Accounts To Load    ${FROM_ACCOUNT_SELECT}
    ${options}=    Get Select Options    ${FROM_ACCOUNT_SELECT}
    Log    From account options: ${options}
    Should Not Be Empty    ${options}    No accounts available in fromAccountId dropdown.
    ${first}=    Get From List    ${options}    0
    ${from_value}=    Get From Dictionary    ${first}    value
    Log    From account value: ${from_value}
    RETURN    ${from_value}

Check To Account
    [Documentation]    Retrieves the value of the "to account" option that is different from the provided "from account" value.
    [Arguments]    ${from_account_value}
    Wait For Elements State    ${TO_ACCOUNT_SELECT}    visible    5s
    ${options}=    Get Select Options    ${TO_ACCOUNT_SELECT}
    Log    To account options: ${options}
    FOR    ${option}    IN    @{options}
        ${value}=    Get From Dictionary    ${option}    value
        Return From Keyword If    '${value}' != '${from_account_value}'    ${value}
    END
    Fail    No different account available for to account.

Enter Transfer Amount
    [Documentation]    Enters the amount to transfer in the transfer funds form.
    [Arguments]    ${amount}
    Fill Text    ${TRANSFER_AMOUNT_FIELD}    txt=${amount}
    RETURN    ${amount}

Transfer Funds
    [Documentation]    Clicks the button to perform the fund transfer and waits for the confirmation message.
    [Arguments]    ${money}    ${from_value}    ${to_value}
    Click    ${TRANSFER_SUBMIT_BUTTON}
