# macos-tags

Port of [dmkskn/macos-tags](https://github.com/dmkskn/macos-tags) to Ruby

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'macos-tags'
```

And then execute:

```shell
$ bundle install
```

Or install it yourself as:

```shell
$ gem install macos-tags
```

## Usage

```ruby
require 'macos-tags'
```

### Get all tags

```ruby
MacosTags.all_tags
=> [
  #<struct MacosTags::Tag label="Urgent", color=#<MacosTags::Color @name="yellow" @value=5>>,
]
```

### Find files by tag

```ruby
> MacosTags.find_files(tag: "Urgent")
=> [
  "files"...
]
```

### Count files by tag

```ruby
> MacosTags.count(tag: "Urgent")
=> 22
```

### List tags on the file


```ruby
MacosTags.tags(file: "/Users/me/Documents/note.txt")
=>
[
  #<struct MacosTags::Tag label="Urgent", color=#<MacosTags::Color @name="red" @value=6>>,
  #<struct MacosTags::Tag label="Important", color=#<MacosTags::Color @name="yellow" @value=5>>
]
```

## TODOs

- [ ] Enable it to add tags
- [ ] Enable it to remove tags

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/tomoya55/macos-tags.

