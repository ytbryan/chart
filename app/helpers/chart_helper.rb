module ChartHelper
  #
  # D3.js related chart
  #

  def horizontal_grouped_bar id=nil, size=nil, data=nil
    html = "<div style=\"width: #{size[:width]}px; height: #{size[:height]}px;\" id=\"horizontal_grouped_bar_#{id}\" class='with-3d-shadow with-transitions'><svg></svg></div>".html_safe
    script = javascript_tag do
      <<-END.html_safe
      var chart;
      nv.addGraph(function() {
          chart = nv.models.multiBarHorizontalChart()
              .x(function(d) { return d.label })
              .y(function(d) { return d.value })
              .yErr(function(d) { return [-Math.abs(d.value * Math.random() * 0.3), Math.abs(d.value * Math.random() * 0.3)] })
              .barColor(d3.scale.category20().range())
              .duration(250)
              .margin({left: 100})
              .stacked(true);

          chart.yAxis.tickFormat(d3.format(',.2f'));

          chart.yAxis.axisLabel('Y Axis');
          chart.xAxis.axisLabel('X Axis').axisLabelDistance(20);

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

  def discrete_bar id=nil, size=nil, data=nil
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
                .duration(250)
                ;

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

  def boxplot id=nil, size=nil, data=nil
    html = "<div style=\"width: #{size[:width]}px; height: #{size[:height]}px;\" class=\"gallery\" id=\"boxplot_#{id}\"><svg></svg></div>".html_safe
    script = javascript_tag do
      <<-END.html_safe
        nv.addGraph(function() {
          var chart = nv.models.boxPlotChart()
              .x(function(d) { return d.label })
              .y(function(d) { return d.values.Q3 })
              .staggerLabels(true)
              .maxBoxWidth(75) // prevent boxes from being incredibly wide
              .yDomain([0, 500]);
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
    html  = "<canvas id=\"pie_#{id}\" height=\"450\" width=\"600\"></canvas>".html_safe
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
    html  = "<canvas id=\"radar_#{id}\" height=\"450\" width=\"600\"></canvas>".html_safe
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
