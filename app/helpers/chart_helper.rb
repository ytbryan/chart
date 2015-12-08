module ChartHelper
  #
  # D3.js related chart
  #


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
    html + script
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
