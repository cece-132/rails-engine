# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby/Rails version
 - ruby 2.7.2p137 (2020-10-01 revision 5445e04352) [x86_64-darwin21]
 - Rails 5.2.8.1

* System dependencies
  - RSpec
  - SimpleCov

* Configuration

* Database creation

* Database initialization

* How to run the test suite
  - `bundle exec rspec spec/...`

* Services (job queues, cache servers, search engines, etc.)
You are working for a company developing an E-Commerce Application. Your team is working in a service-oriented architecture, meaning the front and back ends of this application are separate and communicate via APIs. Your job is to expose the data that powers the site through an API that the front end will consume.

* Deployment instructions
  - type `rails server` in terminal
  - open browser to `http://localhost:3000/`
  
  This api should return data for the following endpoints
  A. Merchants:
   1. get all merchants
   2. get one merchant
   3. get all items for a given merchant ID
   4. find an merchant that matches a search term
   5. find all merchants that match a search term

  B. Items:
    6. get all items
    7. get one item
    8. create an item
    9. edit an item
    10. delete an item
    11. get the merchant data for a given item ID
    12. find an item that matches a search term
    13. find all items that match a search term (searching the name and description)
    14. find the items the are greater than or equal to the search_term for min_price
    14. find the items the are less than or equal to the search_term for max_price
    14. find the items the are between the search_term for min_price and max_price


# PR TEMPLATE
------
## Pull request type
Please check the type of change your PR introduces:
- [ ] Bugfix
- [ ] Feature
- [ ] Code style update (formatting, renaming)
- [ ] Refactoring (no functional changes, no api changes)
- [ ] Build related changes
- [ ] Breaking change (fix or feature that would cause existing functionality to not work as expected)
- [ ] Other (please describe):
## Problem/feature
_What problem are you trying to solve?_
## Solution
_How did you solve the problem?_
## Other changes (e.g. bug fixes, UI tweaks, small refactors)
## Checklist
- [ ] Code compiles correctly
- [ ] Tests for the changes have been added (for bug fixes/features)
- [ ] All tests passing
- [ ] Extended the README / documentation, if necessary
