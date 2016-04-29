module Nvd3Helper
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
end
