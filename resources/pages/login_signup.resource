*** Settings ***
Library    Browser

*** Variables ***

# URLs and Page Identifiers

# Login and Signup Page
${LOGIN_URL}    https://automationexercise.com/login
${SIGNUP_PAGE}    id=form
${SIGNUP_PAGE_TEXT}    New User Signup!


# Login Form Elements
${LOGIN_EMAIL_PATH}       //*[@id="form"]/div/div/div[1]/div/form/input[2]
${LOGIN_PASSWORD_PATH}    //*[@id="form"]/div/div/div[1]/div/form/input[3]
${LOGIN_BUTTON}    //*[@id="form"]/div/div/div[1]/div/form/button
${LOGIN_INCORRECT}   //*[@id="form"]/div/div/div[1]/div/form/p
${LOGIN_INCORRECT_TEXT}   text=Your email or password is incorrect!


# Signup Form Elements
${NAME_PATH}        //*[@id="form"]/div/div/div[3]/div/form/input[2]
${NEW_USER_EMAIL_PATH}       //*[@id="form"]/div/div/div[3]/div/form/input[3]
${SIGNUP_BUTTON}    //*[@id="form"]/div/div/div[3]/div/form/button
${SIGNUP_SUCCESS}    text=Enter Account Information

#Account Elements
${GENDER_MR}    id=id_gender1
${USER_NAME}         id=name
${PASSWORD}     id=password
${DAYS}         id=days
${MONTHS}       id=months
${YEARS}        id=years
${FIRST_NAME}   id=first_name
${LAST_NAME}    id=last_name
${ADDRESS1}     id=address1
${COUNTRY}      id=country
${STATE}        id=state
${CITY}         id=city
${ZIPCODE}      id=zipcode
${MOBILE_NUMBER}  id=mobile_number
${CREATE_ACCOUNT_BUTTON}  //*[@id="form"]/div/div/div/div[1]/form/button


*** Keywords ***
Signup Page
    New Page    ${LOGIN_URL}
    ${text}=     Get Text    ${SIGNUP_PAGE}
    Should Contain    ${text}    ${SIGNUP_PAGE_TEXT}

Signup Form
    Fill Text    ${NAME_PATH}        joaop
    Fill Text    ${NEW_USER_EMAIL_PATH}       avlis.ooj@gmail.com
    Click        ${SIGNUP_BUTTON}
    Wait For Elements State    ${SIGNUP_SUCCESS}    visible    10s

Login Form
    Fill Text    ${LOGIN_EMAIL_PATH}   avlis.ooj@gmail.com
    Fill Text    ${LOGIN_PASSWORD_PATH}  123456789
    Click        ${LOGIN_BUTTON}
    
Login Is Correct
    ${text}=     Get Text    //*[@id="header"]/div/div/div/div[2]/div/ul/li[10]/a
    Should Contain    ${text}    Logged in as jpsilva

Account Information
    Click        ${GENDER_MR}
    Fill Text    ${USER_NAME}     jpsilva
    Fill Text    ${PASSWORD}  123456789
    Select Options By    ${DAYS}    value    10
    Select Options By    ${MONTHS}  value    4
    Select Options By    ${YEARS}   value    1990
    Fill Text    ${FIRST_NAME}   joao
    Fill Text    ${LAST_NAME}    silva
    Fill Text    ${ADDRESS1}     Rua da Ruazinha, 123
    Select Options By    ${COUNTRY}  value    United States
    Fill Text    ${STATE}       California
    Fill Text    ${CITY}        Los Angeles
    Fill Text    ${ZIPCODE}      90001
    Fill Text    ${MOBILE_NUMBER}  1234567890
    Click        ${CREATE_ACCOUNT_BUTTON}





