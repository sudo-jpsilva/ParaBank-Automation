*** Settings ***
Library    Browser

*** Variables ***

${HOME_URL}    https://automationexercise.com/
${BUTTON_ACCEPT_COOKIES}    role=button[name="Consent"] 

*** Keywords ***
Home Page Accept Cookies
    New Page    ${HOME_URL}
    Wait For Elements State    ${BUTTON_ACCEPT_COOKIES}    visible    10s
    Click    ${BUTTON_ACCEPT_COOKIES} 

