# Test project on Grape + Ruby Object Mapper


## Requirements
* Ruby 2.2.2
* Postgresql 9+

## Install
    $ bundle
    $ cp config/database.example.yml config/database.yml
    $ rake db:migrate
    $ rackup

and visit [url](http://localhost:9292/api)
## Run tests
    $ rspec
