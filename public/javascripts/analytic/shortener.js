SMBS.Shortener = {}

//
// http://code.google.com/apis/visualization/documentation/index.html
// http://code.google.com/apis/visualization/documentation/gallery/areachart.html
// http://code.google.com/apis/ajax/playground/?type=visualization#area_chart
//
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
        chart.draw(data, {
          width: 620, height: 240, 
          hAxis: {title:'График посещений за весь период'},
          legend: 'none'
        });
     }
  }
}

//
// http://code.google.com/apis/visualization/documentation/gallery/barchart.html
// http://code.google.com/apis/ajax/playground/?type=visualization#bar_chart
//
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
        chart_height = (30 * data.D.length);
        chart.draw(data, { 
          titlePosition: 'none',
          width: 620,
          height: chart_height + 60,
          fontSize: 12,
          chartArea: { top: 1, height: chart_height },
          hAxis: {title: 'Суммарное количество посетителей. *без классификации по городу'},
          legend: 'none'
        });
    }
  }
}