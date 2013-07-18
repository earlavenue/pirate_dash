$(function(){
  var steps = $("#user_activity_graph").data("y-values");

  var plot = $.plot($("#user_activity_graph"),
      [
       { data: steps, label: "Steps" }], {
          series: {
              bars: { show: true,
                      lineWidth: 1,
                      fill: true,
                      fillColor: { colors: [ { opacity: 0.05 }, { opacity: 0.09 } ] },
                      barWidth: .5,
                      hoverable: true,
                      align: "center"
                   },

              shadowSize: 0,
              stack: false
          },
          grid: { hoverable: true,
                 clickable: true,
                 tickColor: "#f9f9f9",
                 borderWidth: 0
              },
          legend: {
                  // show: false
                  labelBoxBorderColor: "#fff"
              },
          colors: ["#1ec1eb"],
          xaxis: {
              ticks: $("#user_activity_graph").data("x-values"),
              font: {
                  size: 12,
                  family: "Open Sans, Arial",
                  variant: "small-caps",
                  color: "#9da3a9"
              }
          },
          yaxis: {
              ticks:3,
              tickDecimals: 0,
              font: {size:12, color: "#9da3a9"}
          }
       });

  function showTooltip(x, y, contents) {
      $('<div id="tooltip">' + contents + '</div>').css( {
          position: 'absolute',
          display: 'none',
          top: y - 30,
          left: x - 50,
          color: "#fff",
          padding: '2px 5px',
          'border-radius': '6px',
          'background-color': '#000',
          opacity: 0.80
      }).appendTo("body").fadeIn(200);
  }

  var previousPoint = null;
  $("#user_activity_graph").bind("plothover", function (event, pos, item) {
      if (item) {
          if (previousPoint != item.dataIndex) {
              previousPoint = item.dataIndex;

              $("#tooltip").remove();
              var x = item.datapoint[0].toFixed(0),
                  y = item.datapoint[1].toFixed(0);

              var month = item.series.xaxis.ticks[item.dataIndex].label;

              showTooltip(item.pageX, item.pageY,
                          item.series.label + " of " + month + ": " + y);
          }
      }
      else {
          $("#tooltip").remove();
          previousPoint = null;
      }
  });
});
