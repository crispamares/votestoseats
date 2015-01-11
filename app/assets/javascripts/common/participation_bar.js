
function formatnumb(x) {
	return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

var barWidth = 800;
var barHeight = 70;

var x = d3.scale.linear()
.range([0, barWidth])
.domain([0, results_json.population]);

var svg = d3.select('#participation_bar svg').style("width", barWidth).style("height", 80);;

var bars = svg.selectAll("g")
.data(participation_numbers)
.enter().append("g")

bars.append("rect")
.attr("width", function(d) { return x(d.amount); })
.attr("height", barHeight)
.style("fill", function(d) { return d.color; });

bars.append("text")
.attr("x", function(d) { return x(d.amount) - 100; })
.attr("y", barHeight / 4)
.attr("dy", ".35em")
.text(function(d) { return d.name; });

bars.append("text")
.attr("x", function(d) { return x(d.amount) - 100; })
.attr("y", barHeight /1.8)
.attr("dy", ".35em")
.text(function(d) { return formatnumb(d.amount) ; });

bars.append("text")
.attr("x", function(d) { return x(d.amount) - 100; })
.attr("y", barHeight /1.2)
.attr("dy", ".35em")
.text(function(d) { if(d.figure){return d.figure+'%'} });
