*** Settings ***
Documentation       Centralized variables for the ParaBank automation project.
...                 All global configuration, URLs, and shared constants are defined here
...                 to avoid scattering variables across multiple resource files.


*** Variables ***
# Browser Configuration
${BASE_URL}                 https://parabank.parasoft.com/parabank
${HOME_URL}                 https://parabank.parasoft.com/parabank/index.htm
${BROWSER}                  firefox
${HEADLESS}                 True

# Account Types
${ACCOUNT_TYPE_SAVINGS}     0
${ACCOUNT_TYPE_CHECKING}    1

# API Test Data
${INVALID_ID}               00000
