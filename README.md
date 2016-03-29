[![Code Climate](https://codeclimate.com/github/adamliesko/aureso_challenge.png)](https://codeclimate.com/github/adamliesko/aureso_challenge)
[![Build Status](https://travis-ci.org/adamliesko/aureso_challenge.png)](https://travis-ci.org/adamliesko/aureso_challenge)

Aureso Challenge
===============================

## Requirements 
   
- use git and commit possible often
- use OOP approach
- use TDD and any test framework which is comfortable for you to build this application
- Time Limit: 7 working days

## Notes

- As discusses, I implemented caching for PricingPolicy. On every startup of the Rails App in prod environment new values are fetched. Additionally, cached margins
are updated in 1h intervals through the use of rufus scheduler.
- Used HTTP Authentication for both defined endpoints, tied to the Organization. Set HTTP Header `Authorization` to the auth_code of your Organization.
- Business constraints related to the slugs or names we open ended - so I assumed they should be always present, set by the user creating them (not auto generated) and unique.

## Development setup

Honorable mentions to used libraries: rspec, factory_girl, webmock, friendly_id, nokogiri, lograge for cleaner logging and puma web server. 
I used Rails version which was described in the attached pdf (4.1.x) with ruby 2.2.3.

```
git clone git@github.com:adamliesko/aureso_challenge.git
cd aureso_challenge
bundle install
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rspec # ensure all tests passes
rails s
```