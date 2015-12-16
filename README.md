![Chart](assets/images/example.gif)

[See an example on heroku](http://chartgemdemo.herokuapp.com) ([Example Source Code](http://github.com/ytbryan/chartdemo))

# Chart
It's still a work in progress. Charts are from
[ChartJS](https://github.com/nnnick/Chart.js/)
and [NVD3](https://github.com/novus/nvd3).

Two flavours to choose from.

ChartJS
* Bar Chart `<%= bar :id_of_your_chart, size, data %>`
* Line Chart `<%= line :id, size, data %>`
* Pie Chart `<%= pie :id, size, data %>`
* Radar Chart `<%= radar :id, size, data %>`
* ~~Donut Chart~~
* ~~Polar Area~~

NVD3
* Box Plot `<%= boxplot :id, size, data %>`
* Discrete Bar `<%= discrete_bar :id, size, data %>`
* Horizontal Grouped Bar `<%= horizontal_grouped_bar :id, size, data %>`
* ~~Simple Line~~
* ~~Scatter/Bubble~~
* ~~Bullet Chart~~
* ~~Pie Chart~~
* ~~Line with view finder~~
* ~~Cumulative Line~~


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

Chart ships with [ChartJS](https://github.com/nnnick/Chart.js/)(1.02)
and [NVD3](https://github.com/novus/nvd3).


## Example Usage

![Chart](assets/images/pie.gif)


At your View
```
<%= pie :pie_chart, @pieSize, @pieData%>
```

At your Controller
```
@pieSize = {
    :height => 500,
    :width => 500
  }

  @pieData = [
        {
          value: 300,
          color:"#F7464A",
          highlight: "#FF5A5E",
          label: "Red"
        },
        {
          value: 50,
          color: "#46BFBD",
          highlight: "#5AD3D1",
          label: "Green"
        },
        {
          value: 100,
          color: "#FDB45C",
          highlight: "#FFC870",
          label: "Yellow"
        },
        {
          value: 40,
          color: "#949FB1",
          highlight: "#A8B3C5",
          label: "Grey"
        },
        {
          value: 120,
          color: "#4D5360",
          highlight: "#616774",
          label: "Dark Grey"
        }

      ].to_json
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake false` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ytbryan/chart. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
