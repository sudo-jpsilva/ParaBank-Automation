*** Settings ***
Library    Browser

*** Variables ***

${HOME_URL}    https://parabank.parasoft.com/parabank/index.htm
${BROWSER}    firefox

*** Keywords ***
Open Browser
    New Browser   ${BROWSER}   false
    
Go to Home Page
    New Page    ${HOME_URL}