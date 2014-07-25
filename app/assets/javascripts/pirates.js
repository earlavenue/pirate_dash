 //  jQuery Flot Chart
        var activated = $("#statsChart").data("y-values");

        var plot = $.plot($("#statsChart"),
            [ { data: activated, label: "Activations"} ], {
                series: {
                    lines: { show: true,
                            lineWidth: 1,
                            fill: true,
                            fillColor: { colors: { opacity: 0.05 }  }
                         },
                    points: { show: true,
                             lineWidth: 2,
                             radius: 3
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
                        show: false,
                        labelBoxBorderColor: "#fff"
                    },
                colors: ["#05e727"],
                xaxis: {
                    ticks: [[1, "JAN"], [2, "FEB"], [3, "MAR"], [4,"APR"], [5,"MAY"], [6,"JUN"],
                           [7,"JUL"], [8,"AUG"], [9,"SEP"],[10, "OCT"],[11, "NOV"], [12, "DEC"],[13, "JAN "]],
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
        $("#statsChart").bind("plothover", function (event, pos, item) {
            if (item) {
                if (previousPoint != item.dataIndex) {
                    previousPoint = item.dataIndex;

                    $("#tooltip").remove();
                    var x = item.datapoint[0].toFixed(0),
                        y = item.datapoint[1].toFixed(0);

                    var month = item.series.xaxis.ticks[item.dataIndex].label;

                    showTooltip(item.pageX, item.pageY,
                                y + " activations as of " + month + " 1");
                }
            }
            else {
                $("#tooltip").remove();
                previousPoint = null;
            }
        });
