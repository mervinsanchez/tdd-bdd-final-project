Feature: The product store service back-end
    As a Product Store Owner
    I need a RESTful catalog service
    So that I can keep track of all my products

Background:
    Given the following products
        | name       | description     | price   | available | category   |
        | Hat        | A red fedora    | 59.95   | True      | CLOTHS     |
        | Shoes      | Blue shoes      | 120.50  | False     | CLOTHS     |
        | Big Mac    | 1/4 lb burger   | 5.99    | True      | FOOD       |
        | Sheets     | Full bed sheets | 87.00   | True      | HOUSEWARES |

Scenario: The server is running
    When I visit the "Home Page"
    Then I should see "Product Catalog Administration" in the title
    And I should not see "404 Not Found"

Scenario: Create a Product
    When I visit the "Home Page"
    And I set the "Name" to "Hammer"
    And I set the "Description" to "Claw hammer"
    And I select "True" in the "Available" dropdown
    And I select "Tools" in the "Category" dropdown
    And I set the "Price" to "34.95"
    And I press the "Create" button
    Then I should see the message "Success"
    When I copy the "Id" field
    And I press the "Clear" button
    Then the "Id" field should be empty
    And the "Name" field should be empty
    And the "Description" field should be empty
    When I paste the "Id" field
    And I press the "Retrieve" button
    Then I should see the message "Success"
    And I should see "Hammer" in the "Name" field
    And I should see "Claw hammer" in the "Description" field
    And I should see "True" in the "Available" dropdown
    And I should see "Tools" in the "Category" dropdown
    And I should see "34.95" in the "Price" field

Scenario: Retrieve a Product by ID
    Given there is a product with name "Laptop" and category "Electronics" with price 1000
    When I request the product by ID
    Then the response status should be 200
    And the product name should be "Laptop"

Scenario: List Products with Filters
    Given there are multiple products in the catalog
    When I request the product list filtered by category "Electronics"
    Then the response status should be 200
    And I should receive 2 products

Scenario: Update an Existing Product
    Given there is a product with name "Phone" and category "Electronics" with price 800
    When I update the product with name "Smartphone" and price 900
    Then the response status should be 200
    And the product should have name "Smartphone" and price 900

Scenario: Delete a Product
    Given there is a product with name "Smartwatch" and category "Electronics" with price 200
    When I delete the product
    Then the response status should be 204
    And the product should not exist in the catalog