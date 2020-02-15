# Depcop

:construction: Still a work in progress, interfaces may be changed.

A checking tool of a ruby class/module dependency graph.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'depcop'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install depcop

## Usage

Depcop is supposed to be used with [Depdump](https://github.com/upinetree/depdump/) (or compatible JSON structures).

Quick start:

    $ cd my/cool/ruby/project
    $ depdump | depcop

or

    $ depcop dep.json
    $ depcop `cat dep.json`

You can try examples in this repo.

    $ depdump examples/circular_dependencies | depcop

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/depcop. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Depcop project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/depcop/blob/master/CODE_OF_CONDUCT.md).
