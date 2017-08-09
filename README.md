# Express
A headless CMS for generating and organizing content.

## Usage


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


## Contributing
Submit a pull request.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
