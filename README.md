# Express
A headless CMS for generating and organizing content.

Rails 5

Ruby 2.3

Postgres

Haml

Dragonfly

Friendly ID

Fontawesome

## Usage

There are 5 data models:

#### Site, Channel, Entry, Setting, and Attachment

Sites have many channels and are used to organize channels.

Channels have many entries and are used to organize content and build dynamic form fields for entries.

Entries are the content records and belong to a channel.

Settings are used to create collections to dynamically build content fields.

Attachments are for storing file uploads. File fields can be dynamically added to entries and rendering sizes specified in the view templates.


## Installation
Add this line to your application's Gemfile:

```ruby
gem 'express', github: 'johndavid400/express'
```

And then execute:
```bash
$ bundle
```

Add this line to your application's config/routes.rb file:


```ruby
mount Express::Engine => "/admin"
```

Note: Change '/admin' to wherever you want to access the CMS pages.

Then copy migrations:
```bash
rake express:install:migrations
```

And migrate db:
```bash
rake db:migrate
```


## Contributing
Submit a pull request.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
