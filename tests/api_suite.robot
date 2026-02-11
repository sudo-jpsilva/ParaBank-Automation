*** Settings ***
Library    RequestsLibrary
Resource    ../resources/common.resource
Resource    ../resources/api.resource

Suite Setup   Suite Setup For API

*** Variables ***

${invalid_id}    00000

*** Test Cases ***
Get Customers Accounts
    [Documentation]    Happy-path test for GET /services/bank/customers/{customer_id}/accounts
    Create Session    parabank    ${BASE_URL}     verify=False

    ${params}=    Create Dictionary    _type=json
    ${response}=    GET On Session
    ...    parabank
    ...    /services/bank/customers/${CUSTOMER_ID}/accounts
    ...    params=${params}
    ...    expected_status=anything

    Should Be Equal As Integers    ${response.status_code}    200
    Log To Console    Response body: ${response.text}

    ${accounts}=    Set Variable    ${response.json()}
    Should Not Be Empty    ${accounts}
    ${count}=    Get Length    ${accounts}
    Should Be True    ${count} >= 1

    FOR    ${i}    IN RANGE    ${count}
        ${account}=    Get From List    ${accounts}    ${i}
        ${account_id}=    Get From Dictionary    ${account}    id
        ${customer_id}=    Get From Dictionary    ${account}    customerId
        ${type}=    Get From Dictionary    ${account}    type
        ${balance}=    Get From Dictionary    ${account}    balance

        Log    Account ID: ${account_id}, Balance: ${balance}, Type: ${type}, Customer ID: ${customer_id} 
    END
    
Get Accounts With Invalid Customer ID
    [Documentation]    Negative test for GET /services/bank/customers/{customer_id}/accounts
    Create Session    parabank    ${BASE_URL}     verify=False

    ${response}=    GET On Session
    ...    parabank
    ...    /services/bank/customers/${invalid_id}/accounts
    ...    expected_status=anything

    Should Be Equal As Integers    ${response.status_code}    400
    Log    Body: ${response.text}
    Should Contain    ${response.text}    Could not find customer #0


Get Customer Information
    [Documentation]    Happy-path test for GET /services/bank/customers/{customer_id}
    Create Session    parabank    ${BASE_URL}     verify=False

    ${params}=    Create Dictionary    _type=json
    ${response}=    GET On Session
    ...    parabank
    ...    /services/bank/customers/${CUSTOMER_ID}
    ...    params=${params}
    ...    expected_status=anything

    Should Be Equal As Integers    ${response.status_code}    200
    Get And Validate Customer Information  expected_first=${FIRSTNAME}    expected_last=${LASTNAME}    
    ...    expected_phone=${PHONE}   expected_address=${ADDRESS}
    ...    expected_city=${CITY}     expected_state=${STATE}  expected_zip=${ZIP}
    ...    expected_ssn=${SSN}


Get Customer Information With Invalid ID
    [Documentation]    Negative test for GET /services/bank/customers/{customer_id}
    Create Session    parabank    ${BASE_URL}     verify=False

    ${response}=    GET On Session
    ...    parabank
    ...    /services/bank/customers/${invalid_id}
    ...    expected_status=anything

    Should Be Equal As Integers    ${response.status_code}    400
    Log    Body: ${response.text}
    Should Contain    ${response.text}    Could not find customer #0

Update Customer Information
    [Documentation]    Happy-path test for POST /services/bank/customers/update/{customer_id}
    Create Session    parabank    ${BASE_URL}     verify=False

    ${params}=    Create Dictionary
    ...    customerId=${CUSTOMER_ID}
    ...    firstName=UpdatedFirstName
    ...    lastName=UpdatedLastName
    ...    phoneNumber=555-9999
    ...    address=Updated Street 123,
    ...    city=Updated City,
    ...    state=UP,
    ...    zipCode=99999,
    ...    ssn=999-99-9999,
    ...    username=${USERNAME},
    ...    password=${PASSWORD},
    ...    _type=json

    ${response}=    POST On Session
    ...    parabank
    ...    /services/bank/customers/update/${CUSTOMER_ID}
    ...    params=${params}
    ...    expected_status=anything

    Should Be Equal As Integers    ${response.status_code}    200
    Should Contain    ${response.text}    Successfully updated customer profile

    # Validar que as informações foram realmente atualizadas
    Get And Validate Customer Information  expected_first=UpdatedFirstName    expected_last=UpdatedLastName    
    ...    expected_phone=555-9999   expected_address=Updated Street 123,  expected_city=Updated City,
    ...    expected_state=UP  expected_zip=99999   expected_ssn=999-99-9999





    


