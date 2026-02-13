*** Settings ***
Resource    ../resources/common.resource

Suite Setup   Suite Setup For API


*** Test Cases ***
Get Customers Accounts
    [Documentation]    Happy-path test for GET /services/bank/customers/{customer_id}/accounts
    [Tags]    api    get    accounts    smoke
    Create Session For API
    ${accounts}=    Get Customer Accounts
    Validate Account List    ${accounts}
    Log To Console    Response body: ${accounts}

Get Accounts With Invalid Customer ID
    [Documentation]    Negative test for GET /services/bank/customers/{customer_id}/accounts
    [Tags]    api    get    accounts    negative    boundary
    Create Session For API
    Get Accounts With Invalid Customer And Validate Error    ${INVALID_ID}

Get Customer Information
    [Documentation]    Happy-path test for GET /services/bank/customers/{customer_id}
    [Tags]    api    get    customer    smoke
        Create Session For API
        ${response}=    Get Customer Information Response    ${CUSTOMER_ID}  expected_status=200
        ${customer}=    Set Variable    ${response.json()}
        Validate Customer Information    ${customer}    ${FIRSTNAME}    ${LASTNAME}    
        ...    ${PHONE}    ${ADDRESS}    ${CITY}    ${STATE}    ${ZIP}     ${SSN}

Get Customer Information With Invalid ID
    [Documentation]    Negative test for GET /services/bank/customers/{customer_id}
    [Tags]    api    get    customer    negative     boundary    
    Create Session For API
    ${response}=    Get Customer Information Response    ${INVALID_ID}    expected_status=400
    Should Contain    ${response.text}    Could not find customer #0

Update Customer Information
    [Documentation]    Happy-path test for POST /services/bank/customers/update/{customer_id}
    [Tags]    api    post    customer    regression    
    Create Session For API
        ${response}    ${first_name}    ${last_name}    ${email}    ${password}    
        ...    ${address}    ${city}    ${state}    ${zip_code}    ${phone_number}    
        ...    ${ssn}    ${username}=    Update Customer Information With Random Data

    ${get_response}=    Get Customer Information Response    ${CUSTOMER_ID}     expected_status=200
    ${customer}=    Set Variable    ${get_response.json()}

    Validate Customer Information    ${customer}    ${first_name}    ${last_name}
    ...    ${phone_number}    ${address}    ${city}    ${state}    ${zip_code}    ${ssn}









