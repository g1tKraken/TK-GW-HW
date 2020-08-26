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
      var cell = row.append("td");
      cell.text(val);
    });
  });
}

var myfilters = {};

var updateFilters = function () {
  var changedElement = d3.select(this).select("input");
  var elementValue = changedElement.property("value");
  var filterId = changedElement.attr("id");

  if (elementValue) {
    myfilters[filterId] = elementValue;
  }
  else {
    delete myfilters[filterId];
  }
  filterTable();

}

var filterTable = function () {
  let filteredData = tableData;
  Object.entries(myfilters).forEach(([key, value]) => {
    filteredData = filteredData.filter(row => row[key] === value);
  });

  dataTable(filteredData);
}

d3.selectAll(".filter").on("change", updateFilters);

dataTable(tableData);
