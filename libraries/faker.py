"""Simple Faker-style library for Robot Framework tests.

Provides random user data like name, email, password and address.

Usage from Robot Framework:

    *** Settings ***
    Library    libraries/faker.py

    *** Test Cases ***
    Example
        ${name}=       Generate Random Name
        ${email}=      Generate Random Email
        ${password}=   Generate Random Password
"""

import random
import string


FIRST_NAMES = ["John", "Jane", "Alice", "Bob", "Charlie", "Diana"]
LAST_NAMES = ["Smith", "Doe", "Johnson", "Brown", "Davis", "Miller"]
STREETS = ["Main St", "High St", "Park Ave", "Oak St", "Pine St"]
CITIES = ["New York", "Los Angeles", "Chicago", "Houston", "Phoenix"]
STATES = ["NY", "CA", "IL", "TX", "AZ"]


def generate_first_name() -> str:
    return random.choice(FIRST_NAMES)


def generate_last_name() -> str:
    return random.choice(LAST_NAMES)


def generate_random_name() -> str:
    return f"{generate_first_name()} {generate_last_name()}"


def generate_random_email(domain: str | None = None) -> str:
    """Return random email like ``abcd1234@example.com``.

    Optional ``domain`` allows forcing a specific domain.
    """

    domains = ["example.com", "test.com", "sample.com"]
    local_part = "".join(random.choices(string.ascii_lowercase + string.digits, k=8))
    selected_domain = domain or random.choice(domains)
    return f"{local_part}@{selected_domain}"


def generate_random_password(length: int = 10) -> str:
    """Return random password with letters and digits."""

    alphabet = string.ascii_letters + string.digits
    return "".join(random.choices(alphabet, k=length))


def generate_address() -> str:
    number = random.randint(100, 999)
    return f"{number} {random.choice(STREETS)}"


def generate_city() -> str:
    return random.choice(CITIES)


def generate_state() -> str:
    return random.choice(STATES)


def generate_zip_code() -> str:
    return "".join(random.choices(string.digits, k=5))


def generate_random_address() -> str:
    zip_code = generate_zip_code()
    return f"{generate_address()}, {generate_city()}, {generate_state()} {zip_code}"


def generate_phone_number() -> str:
    """Return random US-style phone number, e.g. 555-123-4567."""

    digits = "".join(random.choices(string.digits, k=10))
    return f"{digits[0:3]}-{digits[3:6]}-{digits[6:10]}"


def generate_ssn() -> str:
    """Return random SSN-like string, e.g. 123-45-6789 (for tests only)."""

    digits = "".join(random.choices(string.digits, k=9))
    return f"{digits[0:3]}-{digits[3:5]}-{digits[5:9]}"


def generate_username() -> str:
    base = "".join(random.choices(string.ascii_lowercase, k=6))
    suffix = "".join(random.choices(string.digits, k=3))
    return f"{base}{suffix}"

