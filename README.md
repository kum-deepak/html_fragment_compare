# HtmlFragmentCompare

Compare HTML fragments ignoring white spaces, comments, and different ordering of attributes.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'html_fragment_compare'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install html_fragment_compare

## Usage

Before you use it, add:

```ruby
require 'html_fragment_compare'
```

```ruby
    
    expect(HtmlFragmentCompare.eql?('<h1 />', '<h1 />')).to eq(true)

    expect(HtmlFragmentCompare.eql?('<h2 />', '<h1 />')).to eq(false)
    
    s1= '
      <div class="show-image no-padding col-xs-12 col-sm-6 col-md-5">
        <a href="/kreatio/kreatio-blog/1000393/incremental-demographics" title="">
            <img alt="Incremental Demographics" src="/w-images/bcf25e0d-9fbe-4293-ba7c-58c0de9eaadd/2/demographics-154x190.jpg">
        </a>
      </div>
    '
    s2= '
      <div class="show-image no-padding col-xs-12 col-sm-6 col-md-5">
        <a title="" href="/kreatio/kreatio-blog/1000393/incremental-demographics">
            <img src="/w-images/bcf25e0d-9fbe-4293-ba7c-58c0de9eaadd/2/demographics-154x190.jpg" alt="Incremental Demographics" >
        </a>
      </div>
    '

    expect(HtmlFragmentCompare.eql?(s1, s2)).to eq(true)

```

See the spec folder for more examples.

## Notes

Though all examples are using `rspec`. The gem can be used anywhere. Only external dependency is `nokogiri`.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/kum-deepak/html_fragment_compare/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
