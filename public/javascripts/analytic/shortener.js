SMBS.Shortener = {}

SMBS.Shortener.Clicks = {
  init: function(short_url_id) {
    google.load("visualization", "1", {packages:["corechart"]});
    google.setOnLoadCallback(initialize);

    function initialize() {
      var query = new google.visualization.Query("/ds/shortener/"+ short_url_id +"/clicks");
      query.send(handleQueryResponse);
    }

    function handleQueryResponse(response) {
        if (response.isError()) {
          console.log('Error in query: ' + response.getMessage() + ' ' + response.getDetailedMessage());
          return;
        }
      
        var data = response.getDataTable();
        var chart = new google.visualization.AreaChart(document.getElementById('clicks_report'));
        chart.draw(data, {
          width: 600, height: 240, hAxis: {title:'График посещений за весь период'}
        });
      }
  }
}

SMBS.Shortener.Regions = {
  init: function(short_url_id) {
    google.load("visualization", "1", {packages:["corechart"]});
    google.setOnLoadCallback(drawChart);
    function drawChart() {
      var data = new google.visualization.DataTable();
      data.addColumn('string', 'Year');
      data.addColumn('number', 'Sales');
      data.addColumn('number', 'Expenses');
      data.addRows(4);
      data.setValue(0, 0, '2004');
      data.setValue(0, 1, 1000);
      data.setValue(0, 2, 400);
      data.setValue(1, 0, '2005');
      data.setValue(1, 1, 1170);
      data.setValue(1, 2, 460);
      data.setValue(2, 0, '2006');
      data.setValue(2, 1, 660);
      data.setValue(2, 2, 1120);
      data.setValue(3, 0, '2007');
      data.setValue(3, 1, 1030);
      data.setValue(3, 2, 540);

      var chart = new google.visualization.BarChart(document.getElementById('regions_report'));
      chart.draw(data, {width: 400, height: 240, title: 'Company Performance',
                        vAxis: {title: 'Year', titleColor: 'red'}
                       });
    }
  }
}