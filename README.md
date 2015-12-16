![Chart](assets/images/chart.gif)

[See an example on heroku](http://chartgemdemo.herokuapp.com) ([Source](http://github.com/ytbryan/chartdemo))

# Chart

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'chart'
```

At application.js, write `//= require chart` after turbolinks

```
//= require turbolinks
//= require chart
//= require nvd3
```

At application.css, write `*= require nvd3`

```
*= require tree
*= require nvd3
```

## Important

Chart ships with ChartJS (1.02) and NVD3.

ChartJS
* Bar Chart
* Line Chart
* Pie Chart
* Radar Chart

NVD3
* Box Plot
* Discrete Bar
* Horizontal Grouped Bar

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake false` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ytbryan/chart. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
