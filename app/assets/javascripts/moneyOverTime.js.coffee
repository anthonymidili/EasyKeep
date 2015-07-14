jQuery ->
  $('#moneyOverTime').highcharts
    chart: zoomType: 'x'
    title: text: 'Income Over Time'
    subtitle: text: if document.ontouchstart == undefined then 'Click and drag in the plot area to zoom in' else 'Pinch the chart to zoom in'
    xAxis: type: 'datetime'
    yAxis: title: text: 'Money'
    tooltip: valuePrefix: '$'
    legend: enabled: false
    plotOptions: area:
      fillColor:
        linearGradient:
          x1: 0
          y1: 0
          x2: 0
          y2: 1
        stops: [
          [
            0
            Highcharts.getOptions().colors[0]
          ]
          [
            1
            Highcharts.Color(Highcharts.getOptions().colors[0]).setOpacity(0).get('rgba')
          ]
        ]
      marker: radius: 2
      lineWidth: 1
      states: hover: lineWidth: 1
      threshold: null
    series: [ {
      type: 'area'
      name: 'Income'
      data: $('#moneyOverTime').data('amounts')
    } ]
  return
