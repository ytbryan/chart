module ChartHelper


  #NVD3
  def nvd3_bar
    html = "".html_safe
    # html = "<div id=\"chart\" style=\"min-width: 310px; height: 400px; margin: 0 auto\"><svg></svg></div>".html_safe
    script = javascript_tag do
      <<-END.html_safe
      var n = 4,
          m = 58,
          stack = d3.layout.stack(),
          layers = stack(d3.range(n).map(function() { return bumpLayer(m, .1); })),
          yGroupMax = d3.max(layers, function(layer) { return d3.max(layer, function(d) { return d.y; }); }),
          yStackMax = d3.max(layers, function(layer) { return d3.max(layer, function(d) { return d.y0 + d.y; }); });

      var margin = {top: 40, right: 10, bottom: 20, left: 10},
          width = 960 - margin.left - margin.right,
          height = 500 - margin.top - margin.bottom;

      var x = d3.scale.ordinal()
          .domain(d3.range(m))
          .rangeRoundBands([0, width], .08);

      var y = d3.scale.linear()
          .domain([0, yStackMax])
          .range([height, 0]);

      var color = d3.scale.linear()
          .domain([0, n - 1])
          .range(["#aad", "#556"]);

      var xAxis = d3.svg.axis()
          .scale(x)
          .tickSize(0)
          .tickPadding(6)
          .orient("bottom");

      var svg = d3.select("body").append("svg")
          .attr("width", width + margin.left + margin.right)
          .attr("height", height + margin.top + margin.bottom)
        .append("g")
          .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

      var layer = svg.selectAll(".layer")
          .data(layers)
        .enter().append("g")
          .attr("class", "layer")
          .style("fill", function(d, i) { return color(i); });

      var rect = layer.selectAll("rect")
          .data(function(d) { return d; })
        .enter().append("rect")
          .attr("x", function(d) { return x(d.x); })
          .attr("y", height)
          .attr("width", x.rangeBand())
          .attr("height", 0);

      rect.transition()
          .delay(function(d, i) { return i * 10; })
          .attr("y", function(d) { return y(d.y0 + d.y); })
          .attr("height", function(d) { return y(d.y0) - y(d.y0 + d.y); });

      svg.append("g")
          .attr("class", "x axis")
          .attr("transform", "translate(0," + height + ")")
          .call(xAxis);

      d3.selectAll("input").on("change", change);

      var timeout = setTimeout(function() {
        d3.select("input[value=\\"grouped\\"]").property("checked", true).each(change);
      }, 2000);

      function change() {
        clearTimeout(timeout);
        if (this.value === "grouped") transitionGrouped();
        else transitionStacked();
      }

      function transitionGrouped() {
        y.domain([0, yGroupMax]);

        rect.transition()
            .duration(500)
            .delay(function(d, i) { return i * 10; })
            .attr("x", function(d, i, j) { return x(d.x) + x.rangeBand() / n * j; })
            .attr("width", x.rangeBand() / n)
          .transition()
            .attr("y", function(d) { return y(d.y); })
            .attr("height", function(d) { return height - y(d.y); });
      }

      function transitionStacked() {
        y.domain([0, yStackMax]);

        rect.transition()
            .duration(500)
            .delay(function(d, i) { return i * 10; })
            .attr("y", function(d) { return y(d.y0 + d.y); })
            .attr("height", function(d) { return y(d.y0) - y(d.y0 + d.y); })
          .transition()
            .attr("x", function(d) { return x(d.x); })
            .attr("width", x.rangeBand());
      }

      function bumpLayer(n, o) {

        function bump(a) {
          var x = 1 / (.1 + Math.random()),
              y = 2 * Math.random() - .5,
              z = 10 / (.1 + Math.random());
          for (var i = 0; i < n; i++) {
            var w = (i / n - y) * z;
            a[i] += x * Math.exp(-w * w);
          }
        }

        var a = [], i;
        for (i = 0; i < n; ++i) a[i] = o + o * Math.random();
        for (i = 0; i < 5; ++i) bump(a);
        return a.map(function(d, i) { return {x: i, y: Math.max(0, d)}; });
      }

      END
    end
    return html + script

  end

  def nvd3_pie
    html = "<div id=\"chart\" style=\"min-width: 310px; height: 400px; margin: 0 auto\"><svg></svg></div>".html_safe
    script = javascript_tag do
      <<-END.html_safe
      nv.addGraph(function() {
        var chart = nv.models.pieChart()
            .x(function(d) { return d.label })
            .y(function(d) { return d.value })
            .showLabels(true);

          d3.select("#chart svg")
              .datum(exampleData())
              .transition().duration(350)
              .call(chart);

        return chart;
      });

      //Donut chart example
      nv.addGraph(function() {
        var chart = nv.models.pieChart()
            .x(function(d) { return d.label })
            .y(function(d) { return d.value })
            .showLabels(true)     //Display pie labels
            .labelThreshold(.05)  //Configure the minimum slice size for labels to show up
            .labelType("percent") //Configure what type of data to show in the label. Can be "key", "value" or "percent"
            .donut(true)          //Turn on Donut mode. Makes pie chart look tasty!
            .donutRatio(0.35)     //Configure how big you want the donut hole size to be.
            ;

          d3.select("#chart2 svg")
              .datum(exampleData())
              .transition().duration(350)
              .call(chart);

        return chart;
      });

      //Pie chart example data. Note how there is only a single array of key-value pairs.
      function exampleData() {
        return  [
            {
              "label": "One",
              "value" : 29.765957771107
            } ,
            {
              "label": "Two",
              "value" : 0
            } ,
            {
              "label": "Three",
              "value" : 32.807804682612
            } ,
            {
              "label": "Four",
              "value" : 196.45946739256
            } ,
            {
              "label": "Five",
              "value" : 0.19434030906893
            } ,
            {
              "label": "Six",
              "value" : 98.079782601442
            } ,
            {
              "label": "Seven",
              "value" : 13.925743130903
            } ,
            {
              "label": "Eight",
              "value" : 5.1387322875705
            }
          ];
      }

      END
    end
    return html + script

  end

  def nvd3_area
    html = "<div id=\"chart\" style=\"min-width: 310px; height: 400px; margin: 0 auto\"><svg></svg></div>".html_safe
    script = javascript_tag do
      <<-END.html_safe
      var margin = {top: 20, right: 20, bottom: 30, left: 50},
          width = 960 - margin.left - margin.right,
          height = 500 - margin.top - margin.bottom;

      var parseDate = d3.time.format("%y-%b-%d").parse,
          formatPercent = d3.format(".0%");

      var x = d3.time.scale()
          .range([0, width]);

      var y = d3.scale.linear()
          .range([height, 0]);

      var color = d3.scale.category20();

      var xAxis = d3.svg.axis()
          .scale(x)
          .orient("bottom");

      var yAxis = d3.svg.axis()
          .scale(y)
          .orient("left")
          .tickFormat(formatPercent);

      var area = d3.svg.area()
          .x(function(d) { return x(d.date); })
          .y0(function(d) { return y(d.y0); })
          .y1(function(d) { return y(d.y0 + d.y); });

      var stack = d3.layout.stack()
          .values(function(d) { return d.values; });

      var svg = d3.select("body").append("svg")
          .attr("width", width + margin.left + margin.right)
          .attr("height", height + margin.top + margin.bottom)
        .append("g")
          .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

      d3.tsv("data.tsv", function(error, data) {
        if (error) throw error;

        color.domain(d3.keys(data[0]).filter(function(key) { return key !== "date"; }));

        data.forEach(function(d) {
          d.date = parseDate(d.date);
        });

        var browsers = stack(color.domain().map(function(name) {
          return {
            name: name,
            values: data.map(function(d) {
              return {date: d.date, y: d[name] / 100};
            })
          };
        }));

        x.domain(d3.extent(data, function(d) { return d.date; }));

        var browser = svg.selectAll(".browser")
            .data(browsers)
          .enter().append("g")
            .attr("class", "browser");

        browser.append("path")
            .attr("class", "area")
            .attr("d", function(d) { return area(d.values); })
            .style("fill", function(d) { return color(d.name); });

        browser.append("text")
            .datum(function(d) { return {name: d.name, value: d.values[d.values.length - 1]}; })
            .attr("transform", function(d) { return "translate(" + x(d.value.date) + "," + y(d.value.y0 + d.value.y / 2) + ")"; })
            .attr("x", -6)
            .attr("dy", ".35em")
            .text(function(d) { return d.name; });

        svg.append("g")
            .attr("class", "x axis")
            .attr("transform", "translate(0," + height + ")")
            .call(xAxis);

        svg.append("g")
            .attr("class", "y axis")
            .call(yAxis);
      });

      END
    end
    return html + script

  end

  # def nvd3_pie
  #   html = "<div id=\"chart\" style=\"min-width: 310px; height: 400px; margin: 0 auto\"><svg></svg></div>".html_safe
  #   script = javascript_tag do
  #     <<-END.html_safe
  #     nv.addGraph(function() {
  #       var chart = nv.models.pieChart()
  #           .x(function(d) { return d.label })
  #           .y(function(d) { return d.value })
  #           .showLabels(true);
  #
  #         d3.select("#chart svg")
  #             .datum(exampleData())
  #             .transition().duration(350)
  #             .call(chart);
  #
  #       return chart;
  #     });
  #
  #     //Donut chart example
  #     nv.addGraph(function() {
  #       var chart = nv.models.pieChart()
  #           .x(function(d) { return d.label })
  #           .y(function(d) { return d.value })
  #           .showLabels(true)     //Display pie labels
  #           .labelThreshold(.05)  //Configure the minimum slice size for labels to show up
  #           .labelType("percent") //Configure what type of data to show in the label. Can be "key", "value" or "percent"
  #           .donut(true)          //Turn on Donut mode. Makes pie chart look tasty!
  #           .donutRatio(0.35)     //Configure how big you want the donut hole size to be.
  #           ;
  #
  #         d3.select("#chart2 svg")
  #             .datum(exampleData())
  #             .transition().duration(350)
  #             .call(chart);
  #
  #       return chart;
  #     });
  #
  #     //Pie chart example data. Note how there is only a single array of key-value pairs.
  #     function exampleData() {
  #       return  [
  #           {
  #             "label": "One",
  #             "value" : 29.765957771107
  #           } ,
  #           {
  #             "label": "Two",
  #             "value" : 0
  #           } ,
  #           {
  #             "label": "Three",
  #             "value" : 32.807804682612
  #           } ,
  #           {
  #             "label": "Four",
  #             "value" : 196.45946739256
  #           } ,
  #           {
  #             "label": "Five",
  #             "value" : 0.19434030906893
  #           } ,
  #           {
  #             "label": "Six",
  #             "value" : 98.079782601442
  #           } ,
  #           {
  #             "label": "Seven",
  #             "value" : 13.925743130903
  #           } ,
  #           {
  #             "label": "Eight",
  #             "value" : 5.1387322875705
  #           }
  #         ];
  #     }
  #
  #     END
  #   end
  #   return html + script
  # end

  #
  # TO DO
  # Highcharts
  def hLine
    html = "<div id=\"container\" style=\"min-width: 310px; height: 400px; margin: 0 auto\"></div>".html_safe
    script = javascript_tag do
      <<-END.html_safe
          $(function () {
        $('#container').highcharts({
            title: {
                text: 'Monthly Average Temperature',
                x: -20 //center
            },
            subtitle: {
                text: 'Source: WorldClimate.com',
                x: -20
            },
            xAxis: {
                categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
            },
            yAxis: {
                title: {
                    text: 'Temperature (°C)'
                },
                plotLines: [{
                    value: 0,
                    width: 1,
                    color: '#808080'
                }]
            },
            tooltip: {
                valueSuffix: '°C'
            },
            legend: {
                layout: 'vertical',
                align: 'right',
                verticalAlign: 'middle',
                borderWidth: 0
            },
            series: [{
                name: 'Tokyo',
                data: [7.0, 6.9, 9.5, 14.5, 18.2, 21.5, 25.2, 26.5, 23.3, 18.3, 13.9, 9.6]
            }, {
                name: 'New York',
                data: [-0.2, 0.8, 5.7, 11.3, 17.0, 22.0, 24.8, 24.1, 20.1, 14.1, 8.6, 2.5]
            }, {
                name: 'Berlin',
                data: [-0.9, 0.6, 3.5, 8.4, 13.5, 17.0, 18.6, 17.9, 14.3, 9.0, 3.9, 1.0]
            }, {
                name: 'London',
                data: [3.9, 4.2, 5.7, 8.5, 11.9, 15.2, 17.0, 16.6, 14.2, 10.3, 6.6, 4.8]
            }]
        });
    });
      END
    end
    return html + script
  end

  def hArea
    html = "<div id=\"container_area\" style=\"min-width: 310px; height: 400px; margin: 0 auto\"></div>".html_safe
    script = javascript_tag do
      <<-END.html_safe
      $(function () {
          $('#container_area').highcharts({
              chart: {
                  type: 'area'
              },
              title: {
                  text: 'US and USSR nuclear stockpiles'
              },
              subtitle: {
                  text: 'Source: <a href="http://thebulletin.metapress.com/content/c4120650912x74k7/fulltext.pdf">' +
                      'thebulletin.metapress.com</a>'
              },
              xAxis: {
                  allowDecimals: false,
                  labels: {
                      formatter: function () {
                          return this.value; // clean, unformatted number for year
                      }
                  }
              },
              yAxis: {
                  title: {
                      text: 'Nuclear weapon states'
                  },
                  labels: {
                      formatter: function () {
                          return this.value / 1000 + 'k';
                      }
                  }
              },
              tooltip: {
                  pointFormat: '{series.name} produced <b>{point.y:,.0f}</b><br/>warheads in {point.x}'
              },
              plotOptions: {
                  area: {
                      pointStart: 1940,
                      marker: {
                          enabled: false,
                          symbol: 'circle',
                          radius: 2,
                          states: {
                              hover: {
                                  enabled: true
                              }
                          }
                      }
                  }
              },
              series: [{
                  name: 'USA',
                  data: [null, null, null, null, null, 6, 11, 32, 110, 235, 369, 640,
                      1005, 1436, 2063, 3057, 4618, 6444, 9822, 15468, 20434, 24126,
                      27387, 29459, 31056, 31982, 32040, 31233, 29224, 27342, 26662,
                      26956, 27912, 28999, 28965, 27826, 25579, 25722, 24826, 24605,
                      24304, 23464, 23708, 24099, 24357, 24237, 24401, 24344, 23586,
                      22380, 21004, 17287, 14747, 13076, 12555, 12144, 11009, 10950,
                      10871, 10824, 10577, 10527, 10475, 10421, 10358, 10295, 10104]
              }, {
                  name: 'USSR/Russia',
                  data: [null, null, null, null, null, null, null, null, null, null,
                      5, 25, 50, 120, 150, 200, 426, 660, 869, 1060, 1605, 2471, 3322,
                      4238, 5221, 6129, 7089, 8339, 9399, 10538, 11643, 13092, 14478,
                      15915, 17385, 19055, 21205, 23044, 25393, 27935, 30062, 32049,
                      33952, 35804, 37431, 39197, 45000, 43000, 41000, 39000, 37000,
                      35000, 33000, 31000, 29000, 27000, 25000, 24000, 23000, 22000,
                      21000, 20000, 19000, 18000, 18000, 17000, 16000]
              }]
          });
      });
      END
    end
    return html + script
  end

  def hBar
    html = "<div id=\"container_bar\" style=\"min-width: 310px; height: 400px; margin: 0 auto\"></div>".html_safe
    script = javascript_tag do
      <<-END.html_safe
      $(function () {
          $('#container_bar').highcharts({
              chart: {
                  type: 'bar'
              },
              title: {
                  text: 'Historic World Population by Region'
              },
              subtitle: {
                  text: 'Source: <a href="https://en.wikipedia.org/wiki/World_population">Wikipedia.org</a>'
              },
              xAxis: {
                  categories: ['Africa', 'America', 'Asia', 'Europe', 'Oceania'],
                  title: {
                      text: null
                  }
              },
              yAxis: {
                  min: 0,
                  title: {
                      text: 'Population (millions)',
                      align: 'high'
                  },
                  labels: {
                      overflow: 'justify'
                  }
              },
              tooltip: {
                  valueSuffix: ' millions'
              },
              plotOptions: {
                  bar: {
                      dataLabels: {
                          enabled: true
                      }
                  }
              },
              legend: {
                  layout: 'vertical',
                  align: 'right',
                  verticalAlign: 'top',
                  x: -40,
                  y: 80,
                  floating: true,
                  borderWidth: 1,
                  backgroundColor: ((Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF'),
                  shadow: true
              },
              credits: {
                  enabled: false
              },
              series: [{
                  name: 'Year 1800',
                  data: [107, 31, 635, 203, 2]
              }, {
                  name: 'Year 1900',
                  data: [133, 156, 947, 408, 6]
              }, {
                  name: 'Year 2012',
                  data: [1052, 954, 4250, 740, 38]
              }]
          });
      });
      END
    end
    return html + script
  end

  def hPie
    html = "<div id=\"container_pie\" style=\"min-width: 310px; height: 400px; margin: 0 auto\"></div>".html_safe
    script = javascript_tag do
      <<-END.html_safe
      $(function () {
          $('#container_pie').highcharts({
              chart: {
                  plotBackgroundColor: null,
                  plotBorderWidth: null,
                  plotShadow: false,
                  type: 'pie'
              },
              title: {
                  text: 'Browser market shares January, 2015 to May, 2015'
              },
              tooltip: {
                  pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
              },
              plotOptions: {
                  pie: {
                      allowPointSelect: true,
                      cursor: 'pointer',
                      dataLabels: {
                          enabled: true,
                          format: '<b>{point.name}</b>: {point.percentage:.1f} %',
                          style: {
                              color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
                          }
                      }
                  }
              },
              series: [{
                  name: 'Brands',
                  colorByPoint: true,
                  data: [{
                      name: 'Microsoft Internet Explorer',
                      y: 56.33
                  }, {
                      name: 'Chrome',
                      y: 24.03,
                      sliced: true,
                      selected: true
                  }, {
                      name: 'Firefox',
                      y: 10.38
                  }, {
                      name: 'Safari',
                      y: 4.77
                  }, {
                      name: 'Opera',
                      y: 0.91
                  }, {
                      name: 'Proprietary or Undetectable',
                      y: 0.2
                  }]
              }]
          });
      });
      END
    end
    return html + script
  end


  #
  #
  # Google Chart

  def gBar
  end

  def gLine
  end


  #
  # D3.js related chart
  #

  def horizontal_grouped_bar id=nil, size=nil, data=nil, options=nil
    html = "<div style=\"width: #{size[:width]}px; height: #{size[:height]}px;\" id=\"horizontal_grouped_bar_#{id}\"><svg></svg></div>".html_safe
    script = javascript_tag do
      <<-END.html_safe
      var chart;
      nv.addGraph(function() {
          chart = nv.models.multiBarHorizontalChart()
              .x(function(d) { return d.label })
              .y(function(d) { return d.value })
              //.yErr(function(d) { return [-Math.abs(d.value * Math.random() * 0.3), Math.abs(d.value * Math.random() * 0.3)] })
              //.barColor(d3.scale.category20().range())
              //.duration(250)
              .showValues(true)
              //.margin({left: 100})
              .stacked(false);

          chart.yAxis.tickFormat(d3.format(',.2f'));

          chart.yAxis.axisLabel('Y Axis');
          chart.xAxis.axisLabel('X Axis').axisLabelDistance(100);

          d3.select('#horizontal_grouped_bar_#{id} svg')
              .datum(#{data})
              .call(chart);

          nv.utils.windowResize(chart.update);

          chart.dispatch.on('stateChange', function(e) { nv.log('New State:', JSON.stringify(e)); });
          chart.state.dispatch.on('change', function(state){
              nv.log('state', JSON.stringify(state));
          });
          return chart;
      });

    END
    end

    return html + script
  end

  def discrete_bar id=nil, size=nil, data=nil, options=nil
    html = "<div style=\"width: #{size[:width]}px; height: #{size[:height]}px;\" id=\"discrete_bar_#{id}\"><svg></svg></div>".html_safe
    script = javascript_tag do
      <<-END.html_safe
        nv.addGraph(function() {
            var chart = nv.models.discreteBarChart()
                .x(function(d) { return d.label })
                .y(function(d) { return d.value })
                .staggerLabels(true)
                //.staggerLabels(historicalBarChart[0].values.length > 8)
                .showValues(true)
                //.duration(250);

            d3.select('#discrete_bar_#{id} svg')
                .datum(#{data})
                .call(chart);
            nv.utils.windowResize(chart.update);
            return chart;
        });
    END
    end

    return html + script
  end

  def boxplot id=nil, size=nil, data=nil, options=nil
    html = "<div style=\"width: #{size[:width]}px; height: #{size[:height]}px;\" class=\"gallery\" id=\"boxplot_#{id}\"><svg></svg></div>".html_safe
    script = javascript_tag do
      <<-END.html_safe
        nv.addGraph(function() {
          var chart = nv.models.boxPlotChart()
              .x(function(d) { return d.label })
              .y(function(d) { return d.values.Q3 })
              .staggerLabels(true)
              .maxBoxWidth(10) // prevent boxes from being incredibly wide
              .yDomain([0, 700]);
          d3.select('#boxplot_#{id} svg')
              .datum(#{data})
              .call(chart);
          nv.utils.windowResize(chart.update);
          return chart;
        });
      END
    end

    return html + script
  end

  #
  # Chartjs
  #
  def bar id=nil, size=nil, data=nil
    html  = "<canvas id=\"bar_#{id}\" height=\"#{size[:height]}\" width=\"#{size[:width]}\"></canvas>".html_safe
    script = javascript_tag do
      <<-END.html_safe
        var barChartData = #{data}
        var ctx_#{id} = document.getElementById("bar_#{id}").getContext("2d");
        window.myBar_#{id} = new Chart(ctx_#{id}).Bar(barChartData, {});
      END
    end
    return html + script
  end

  def line id=nil, size=nil, data=nil
    html  = "<canvas id=\"line_#{id}\" height=\"#{size[:height]}\" width=\"#{size[:width]}\"></canvas>".html_safe
    script = javascript_tag do
      <<-END.html_safe
        var lineChartData = #{data}
        var ctx_#{id} = document.getElementById("line_#{id}").getContext("2d");
        window.myLine_#{id} = new Chart(ctx_#{id}).Line(lineChartData, {});
      END
    end
    return html + script
  end

  def pie id=nil, size=nil, data=nil
    html  = "<canvas id=\"pie_#{id}\" height=\"#{size[:height]}\" width=\"#{size[:width]}\"></canvas>".html_safe
    script = javascript_tag do
      <<-END.html_safe
        var pieData = #{data}
				var ctx_#{id} = document.getElementById("pie_#{id}").getContext("2d");
				window.myPie_#{id} = new Chart(ctx_#{id}).Pie(pieData);
      END
    end
    return html + script
  end

  def radar id=nil, size=nil, data=nil
    html  = "<canvas id=\"radar_#{id}\" height=\"#{size[:height]}\" width=\"#{size[:width]}\"></canvas>".html_safe
    script = javascript_tag do
      <<-END.html_safe
        var radarChartData = #{data}
        window.myRadar_#{id} = new Chart(document.getElementById("radar_#{id}").getContext("2d")).Radar(radarChartData, {
        });
      END
    end
    return html + script
  end
end
