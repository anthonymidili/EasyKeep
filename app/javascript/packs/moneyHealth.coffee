document.addEventListener 'turbolinks:load', ->
  $('#moneyHealth').highcharts
    chart: type: 'bar'
    title: text: 'Money Health'
    xAxis: categories: ['Invoiced', 'Received', 'Owed']
    yAxis: title: text: false
    tooltip: valuePrefix: '$'
    series: [
      {
        name: 'Amount'
        data: $('#moneyHealth').data('amounts')
      }
    ]
  return
