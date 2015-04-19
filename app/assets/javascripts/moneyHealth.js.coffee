jQuery ->
  $('#money_health').highcharts
    chart: type: 'bar'
    title: text: 'Money Health'
    xAxis: categories: ['Invoiced', 'Received', 'Owed']
    yAxis: title: text: false
    series: [
      {
        name: 'Amount'
        data: $('#money_health').data('amounts')
      }
    ]
  return
