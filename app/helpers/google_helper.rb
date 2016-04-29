module GoogleHelper

    #
    #
    # Google Chart
    def google_pie
      html = "<div id=\"piechart\" style=\"width: 900px; height: 500px;\"></div>".html_safe
      script = javascript_tag do
        <<-END.html_safe
        google.charts.load('current', {'packages':['corechart']});
      google.charts.setOnLoadCallback(drawChart);
      function drawChart() {

        var data = google.visualization.arrayToDataTable([
          ['Task', 'Hours per Day'],
          ['Work',     11],
          ['Eat',      2],
          ['Commute',  2],
          ['Watch TV', 2],
          ['Sleep',    7]
        ]);

        var options = {
          title: 'My Daily Activities'
        };

        var chart = new google.visualization.PieChart(document.getElementById('piechart'));

        chart.draw(data, options);
      }


        END
      end
      return html + script
    end

    def google_area
      html = "<div id=\"chart_div\" style=\"width: 900px; height: 500px;\"></div>".html_safe
      script = javascript_tag do
        <<-END.html_safe
          google.charts.load('current', {'packages':['corechart']});
          google.charts.setOnLoadCallback(drawChart);
          function drawChart() {
          var data = google.visualization.arrayToDataTable([
            ['Year', 'Sales', 'Expenses'],
            ['2013',  1000,      400],
            ['2014',  1170,      460],
            ['2015',  660,       1120],
            ['2016',  1030,      540]
          ]);

          var options = {
            title: 'Company Performance',
            hAxis: {title: 'Year',  titleTextStyle: {color: '#333'}},
            vAxis: {minValue: 0}
          };

          var chart = new google.visualization.AreaChart(document.getElementById('chart_div'));
          chart.draw(data, options);
          }
        END
      end
      return html + script
    end

    def google_geochart
      html = "<div id=\"regions_div\" style=\"width: 900px; height: 500px;\"></div>".html_safe
      script = javascript_tag do
        <<-END.html_safe
            google.charts.load('current', {'packages':['geochart']});
          google.charts.setOnLoadCallback(drawRegionsMap);

          function drawRegionsMap() {

            var data = google.visualization.arrayToDataTable([
              ['Country', 'Popularity'],
              ['Germany', 200],
              ['United States', 300],
              ['Brazil', 400],
              ['Canada', 500],
              ['France', 600],
              ['RU', 700]
            ]);

            var options = {};

            var chart = new google.visualization.GeoChart(document.getElementById('regions_div'));

            chart.draw(data, options);
          }
        END
      end
      return html + script
    end




    def google_gauge_charts
      html = "<div id=\"chart_div\" style=\"width: 400px; height: 120px;\"></div>".html_safe
      script = javascript_tag do
        <<-END.html_safe
          google.charts.load('current', {'packages':['gauge']});
          google.charts.setOnLoadCallback(drawChart);
          function drawChart() {

          var data = google.visualization.arrayToDataTable([
            ['Label', 'Value'],
            ['Memory', 80],
            ['CPU', 55],
            ['Network', 68]
          ]);

          var options = {
            width: 400, height: 120,
            redFrom: 90, redTo: 100,
            yellowFrom:75, yellowTo: 90,
            minorTicks: 5
          };

          var chart = new google.visualization.Gauge(document.getElementById('chart_div'));

          chart.draw(data, options);

          setInterval(function() {
            data.setValue(0, 1, 40 + Math.round(60 * Math.random()));
            chart.draw(data, options);
          }, 13000);
          setInterval(function() {
            data.setValue(1, 1, 40 + Math.round(60 * Math.random()));
            chart.draw(data, options);
          }, 5000);
          setInterval(function() {
            data.setValue(2, 1, 60 + Math.round(20 * Math.random()));
            chart.draw(data, options);
          }, 26000);
          }

        END
      end
      return html + script
    end



    def google_bar
      html = "<div id=\"barchart_values\" style=\"width: 900px; height: 300px;\"></div>".html_safe
      script = javascript_tag do
        <<-END.html_safe
        google.charts.load("current", {packages:["corechart"]});
        google.charts.setOnLoadCallback(drawChart);
        function drawChart() {
        var data = google.visualization.arrayToDataTable([
          ["Element", "Density", { role: "style" } ],
          ["Copper", 8.94, "#b87333"],
          ["Silver", 10.49, "silver"],
          ["Gold", 19.30, "gold"],
          ["Platinum", 21.45, "color: #e5e4e2"]
        ]);

        var view = new google.visualization.DataView(data);
        view.setColumns([0, 1,
                         { calc: "stringify",
                           sourceColumn: 1,
                           type: "string",
                           role: "annotation" },
                         2]);

        var options = {
          title: "Density of Precious Metals, in g/cm^3",
          width: 600,
          height: 400,
          bar: {groupWidth: "95%"},
          legend: { position: "none" },
        };
        var chart = new google.visualization.BarChart(document.getElementById("barchart_values"));
        chart.draw(view, options);
        }

        END
      end
      return html + script
    end

    def google_bubble
      html = "<div id=\"series_chart_div\" style=\"width: 900px; height: 500px;\"></div>".html_safe
      script = javascript_tag do
        <<-END.html_safe
          google.charts.load('current', {'packages':['corechart']});
          google.charts.setOnLoadCallback(drawSeriesChart);

          function drawSeriesChart() {

          var data = google.visualization.arrayToDataTable([
          ['ID', 'Life Expectancy', 'Fertility Rate', 'Region',     'Population'],
          ['CAN',    80.66,              1.67,      'North America',  33739900],
          ['DEU',    79.84,              1.36,      'Europe',         81902307],
          ['DNK',    78.6,               1.84,      'Europe',         5523095],
          ['EGY',    72.73,              2.78,      'Middle East',    79716203],
          ['GBR',    80.05,              2,         'Europe',         61801570],
          ['IRN',    72.49,              1.7,       'Middle East',    73137148],
          ['IRQ',    68.09,              4.77,      'Middle East',    31090763],
          ['ISR',    81.55,              2.96,      'Middle East',    7485600],
          ['RUS',    68.6,               1.54,      'Europe',         141850000],
          ['USA',    78.09,              2.05,      'North America',  307007000]
          ]);

          var options = {
          title: 'Correlation between life expectancy, fertility rate ' +
                 'and population of some world countries (2010)',
          hAxis: {title: 'Life Expectancy'},
          vAxis: {title: 'Fertility Rate'},
          bubble: {textStyle: {fontSize: 11}}
          };

          var chart = new google.visualization.BubbleChart(document.getElementById('series_chart_div'));
          chart.draw(data, options);
          }

        END
      end
      return html + script
    end


    def google_calendar
      html = "<div id=\"calendar_basic\" style=\"width: 1000px; height: 350px;\"></div>".html_safe
      script = javascript_tag do
        <<-END.html_safe
          google.charts.load("current", {packages:["calendar"]});
          google.charts.setOnLoadCallback(drawChart);

          function drawChart() {
          var dataTable = new google.visualization.DataTable();
          dataTable.addColumn({ type: 'date', id: 'Date' });
          dataTable.addColumn({ type: 'number', id: 'Won/Loss' });
          dataTable.addRows([
            [ new Date(2015, 3, 13), 37032 ],
            [ new Date(2015, 3, 14), 38024 ],
            [ new Date(2015, 3, 15), 38024 ],
            [ new Date(2015, 3, 16), 38108 ],
            [ new Date(2015, 3, 17), 38229 ],
            // Many rows omitted for brevity.
            [ new Date(2016, 9, 4), 38177 ],
            [ new Date(2016, 9, 5), 38705 ],
            [ new Date(2016, 9, 12), 38210 ],
            [ new Date(2016, 9, 13), 38029 ],
            [ new Date(2016, 9, 19), 38823 ],
            [ new Date(2016, 9, 23), 38345 ],
            [ new Date(2016, 9, 24), 38436 ],
            [ new Date(2016, 9, 30), 38447 ]
          ]);

          var chart = new google.visualization.Calendar(document.getElementById('calendar_basic'));

          var options = {
           title: "Red Sox Attendance",
           height: 350,
          };

          chart.draw(dataTable, options);
          }

        END
      end
      return html + script
    end


    # def google_area
    #   html = "".html_safe
    #   script = javascript_tag do
    #     <<-END.html_safe
    #     END
    #   end
    #   return html + script
    # end


end
