*** Settings ***
Library    Browser
Library    Collections


*** Variables ***

${account_type_savings}    0
${account_type_checking}   1

*** Keywords ***

Open New Account
    [Documentation]    Navigates to the Open New Account page.
    Click        xpath=//*[@id="leftPanel"]/ul/li[1]/a
    Wait For Elements State    text=What type of Account would you like to open?    visible    10s

Select Options Type Of Account 
    [Documentation]    Selects the type of account to open.]
    [Arguments]    ${account_type}=${account_type_savings}    
    Select Options By    xpath=//*[@id="type"]    value    ${account_type}
    Wait For Elements State    id=fromAccountId    visible    10s
    Sleep    5s

Select At Least One Acount To Transfer From
    [Documentation]    Selects an account to transfer from when opening a new account.
    ${accounts}=         Get Select Options    id=fromAccountId
    Log    Available accounts: ${accounts}
    ${from_account}=     Get From List        ${accounts}    0
    ${from_account_value}=    Get From Dictionary    ${from_account}    value
    Select Options By    id=fromAccountId    value    ${from_account_value}

Create New Account
    [Documentation]    Clicks the button to create a new account.
    Click    xpath=//div[@id="openAccountForm"]//input[@type="button" and @value="Open New Account"]  
    Wait For Elements State    xpath=//*[@id="newAccountId"]    visible    10s

Capture Account ID
    [Documentation]    Captures the ID of the newly created account from the confirmation page.
    ${account_id}=    Get Text    xpath=//*[@id="newAccountId"]
    Log    New Account ID: ${account_id}    
    Should Not Be Empty    ${account_id}    New account ID was not created by the application.
    RETURN    ${account_id}

Account Overview
    [Documentation]    Navigates to the Account Overview page.
    Click       xpath=//*[@id="leftPanel"]/ul/li[2]/a
    Wait For Elements State    xpath=//h1[normalize-space()="Accounts Overview"]    visible    10s

Check if the new account is present on the table of accounts
    [Documentation]    Verifies that the newly created account appears in the accounts overview table.
    [Arguments]    ${account_id}
    Should Not Be Empty    ${account_id}    Account id argument is empty. Did Capture Account ID fail?
    Wait For Elements State    css=#accountTable >> text=${account_id}    visible    10s
    Log    New account ${account_id} is present in the accounts overview.

Check From Account
    [Documentation]    Retrieves the value of the selected "from account" option.
    Sleep              2s
    ${options}=        Get Select Options    id=fromAccountId
    Log                From account options: ${options}
    Sleep              2s
    Should Not Be Empty    ${options}    No accounts available in fromAccountId dropdown.
    ${first}=          Get From List        ${options}    0
    ${from_value}=     Get From Dictionary  ${first}      value
    Log                From account value: ${from_value}
    RETURN             ${from_value}

Check To Account
    [Documentation]    Retrieves the value of the "to account" option that is different from the provided "from account" value.
    [Arguments]    ${from_account_value}
    Wait For Elements State    id=toAccountId    visible       5s
    ${options}=        Get Select Options    id=toAccountId
    Log                To account options: ${options}
    FOR    ${option}    IN    @{options}
        ${value}=    Get From Dictionary    ${option}    value
        Return From Keyword If    '${value}' != '${from_account_value}'    ${value}
    END
    Fail    No different account available for to account.

Amount to Transfer
    [Documentation]    Enters the amount to transfer in the transfer funds form.
    [Arguments]    ${amount}
    Fill Text   //*[@id="amount"]    txt=${amount}
    RETURN    ${amount}
    
Transfer Funds
    [Documentation]    Clicks the button to perform the fund transfer and waits for the confirmation message.
    [Arguments]     ${money}    ${from_value}    ${to_value}
    Click           xpath=//*[@id="transferForm"]/div[2]/input
    Wait For Elements State    text=$${money}.00 has been transferred from account #${from_value} to account #${to_value}.    visible    5s


