jQuery ->
  $('#income_graph').highcharts
    title:
      text: 'Monthly Company Income'
      x: 0
    subtitle:
      text: ''
      x: 0
    xAxis: categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
    yAxis:
      title: text: 'Money Received'
      plotLines: [ {
        value: 0
        width: 1
        color: '#808080'
      } ]
    tooltip: valuePrefix: '$'
    legend:
      layout: 'vertical'
      align: 'right'
      verticalAlign: 'middle'
      borderWidth: 0
    series: [
      {
        name: 'Income'
        data: $('#income_graph').data('amounts')
      }
    ]
  return
