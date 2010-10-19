SMBS.Shortener = {}

SMBS.Shortener.Clicks = {
  init: function(short_url_id) {
    google.load("visualization", "1", {packages:["corechart"]});
    google.setOnLoadCallback(initialize);

    function initialize() {
      query = new google.visualization.Query("/analytic/shortener/"+ short_url_id +"/clicks.json");
      query.send(handleQueryResponse);
    }

    function handleQueryResponse(response) {
        if (response.isError()) {
          console.log('Error in query: ' + response.getMessage() + ' ' + response.getDetailedMessage());
          return;
        }
      
        data = response.getDataTable();
        chart = new google.visualization.AreaChart(document.getElementById('clicks_report'));
        chart.draw(data, {width: 650, height: 240, hAxis: {title:'График посещений за весь период'} });
     }
  }
}

SMBS.Shortener.Regions = {
  init: function(short_url_id) {
    google.load("visualization", "1", {packages:["corechart"]});
    google.setOnLoadCallback(initialize);
    
    function initialize() {
      query = new google.visualization.Query("/analytic/shortener/"+ short_url_id +"/regions.json");
      query.send(handleQueryResponse);
    }
    
    function handleQueryResponse(response) {
        if (response.isError()) {
          console.log('Error in query: ' + response.getMessage() + ' ' + response.getDetailedMessage());
          return;
        }
        
        data = response.getDataTable();
        chart = new google.visualization.BarChart(document.getElementById('regions_report'));
        chart.draw(data, {width: 650, height: 240, hAxis: {title: 'Суммарное количество нажатий'} });
    }
  }
}