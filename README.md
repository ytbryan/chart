![Chart](assets/images/example.gif)

[See an example on heroku](http://chartgemdemo.herokuapp.com) ([Example Source Code](http://github.com/ytbryan/chartdemo))

# Chart
Chart adds beautiful and reusable charts to Rails.
It's still a work in progress. Charts are from
[ChartJS](https://github.com/nnnick/Chart.js/)
and [NVD3](https://github.com/novus/nvd3).

## Usage

At View
```
<%= horizontal_grouped_bar "horizontal_grouped_bar", @size1, @horizontal_grouped_bar_array%>
```

At Controller
```

@size1 = {
  height: 500,
  width: 500
}

@horizontal_grouped_bar_array = [
      {
          key: 'Series1',
          values: [
              {
                  "label": "Group A" ,
                  "value": -1.8746444827653
              } ,
              {
                  "label": "Group B" ,
                  "value": -8.0961543492239
              } ,
              {
                  "label": "Group C" ,
                  "value": -0.57072943117674
              } ,
              {
                  "label": "Group D" ,
                  "value": -2.4174010336624
              } ,
              {
                  "label": "Group E" ,
                  "value": -0.72009071426284
              } ,
              {
                  "label": "Group F" ,
                  "value": -2.77154485523777
              } ,
              {
                  "label": "Group G" ,
                  "value": -9.90152097798131
              } ,
              {
                  "label": "Group H" ,
                  "value": 14.91445417330854
              } ,
              {
                  "label": "Group I" ,
                  "value": -3.055746319141851
              }
          ]
      },
      {
          key: 'Series2',
          values: [
              {
                  "label": "Group A" ,
                  "value": 25.307646510375
              } ,
              {
                  "label": "Group B" ,
                  "value": 16.756779544553
              } ,
              {
                  "label": "Group C" ,
                  "value": 18.451534877007
              } ,
              {
                  "label": "Group D" ,
                  "value": 8.6142352811805
              } ,
              {
                  "label": "Group E" ,
                  "value": 7.8082472075876
              } ,
              {
                  "label": "Group F" ,
                  "value": 5.259101026956
              } ,
              {
                  "label": "Group G" ,
                  "value": 7.0947953487127
              } ,
              {
                  "label": "Group H" ,
                  "value": 8
              } ,
              {
                  "label": "Group I" ,
                  "value": 21
              }
          ]
      },
      {
          key: 'Series3',
          values: [
              {
                  "label": "Group A" ,
                  "value": -14.307646510375
              } ,
              {
                  "label": "Group B" ,
                  "value": 16.756779544553
              } ,
              {
                  "label": "Group C" ,
                  "value": -18.451534877007
              } ,
              {
                  "label": "Group D" ,
                  "value": 8.6142352811805
              } ,
              {
                  "label": "Group E" ,
                  "value": -7.8082472075876
              } ,
              {
                  "label": "Group F" ,
                  "value": 15.259101026956
              } ,
              {
                  "label": "Group G" ,
                  "value": -0.30947953487127
              } ,
              {
                  "label": "Group H" ,
                  "value": 0
              } ,
              {
                  "label": "Group I" ,
                  "value": 0
              }
          ]
      }
  ].to_json

```

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
*= require_tree .
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
