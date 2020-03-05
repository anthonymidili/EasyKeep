jQuery ->
  $('#moneyOverTimeBar').highcharts
    chart: type: 'column'
    title: text: 'Income Over Time'
    xAxis: type: 'datetime'
    yAxis: title: text: 'Money Amount'
    tooltip: valuePrefix: '$'
    legend: enabled: true
    series: [ {
      name: 'Income'
      data: $('#moneyOverTimeBar').data('amounts')
    } ]
  return
