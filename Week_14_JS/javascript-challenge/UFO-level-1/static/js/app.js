
// from data.js
var tableData = data;

// YOUR CODE HERE!

// BONUS: Refactor to use Arrow Functions!
// data.forEach((weatherReport) => {
//   var row = tbody.append("tr");
//   Object.entries(weatherReport).forEach(([key, value]) => {
//     var cell = row.append("td");
//     cell.text(value);
//   });
// });

var tbody = d3.select("tbody");

var dataTable = function (data) {
  tbody.html("");

  data.forEach((dataRow) => {
    var row = tbody.append("tr");

    Object.values(dataRow).forEach((val) => {
      let cell = row.append("td");
        cell.text(val);
      }
    );
  });
}

var clickHandler = function () {

  var date = d3.select("#datetime").property("value");
  let filteredData = tableData;

  if (date) {
    filteredData = filteredData.filter(row => row.datetime === date);
  }

  dataTable(filteredData);
}

d3.selectAll("#filter-btn").on("click", clickHandler);

dataTable(tableData);
