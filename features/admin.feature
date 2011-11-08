Feature: Administering contacts
  In order to supply and maintain government contact information
  I want to create, view, edit and destroy contacts

  Scenario: List contacts
    Given some contacts exist
    Then I should be able to see all the contacts in alphabetical order

  Scenario: View a contact
    Given a contact exists
    Then I should be able to see the contact's details

  Scenario: Create a contact
    When I enter the details for a new contact
    Then the contact should be created

  Scenario: Edit a contact's name
    Given a contact exists
    When I edit the contact's name
    Then the contact's name should change

  Scenario: Edit a contact's postal address
    Given a contact exists
    When I edit the contact's postal address
    Then the contact's postal address should change

  Scenario: Edit a contact's phone number
    Given a contact exists
    When I edit the contact's phone number
    Then the contact's phone number should change

  Scenario: Add a phone number to a contact
    Given a contact exists
    When I add a phone number to the contact
    Then the contact's details should include the phone number
