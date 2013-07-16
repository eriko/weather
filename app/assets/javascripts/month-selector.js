// A radial selector for month of the year. Implemented in SVG using the D3 library.
// Inspired by CrimeSpotting's hour of day control.
// See http://bl.ocks.org/1207745 for an example of usage
// Copyright (C) 2011 Nelson Minar <nelson@monkey.org>

// Constructor: create a month control.
// Callback: called when the selection changes. Callback is passed the selected array
function monthControl(callback) {

    var changeCallback = callback;
    var selectedMonths = [true, true, true, true, true, true, true, true, true, true, true, true];

// Accessor for which months are currently selected. Returns an array of Booleans.
    this.selected = function () {
        return selectedMonths;
    },
        this.setCallback = function (callback) {
            changeCallback = callback;
        }

// Install the control in the named container. Container is a CSS selector, like "#monthSelector"
    this.install = function (container) {
        var firstMonthToggle = true;
        // Toggle a month, updating state and changing style
        function toggleMonth(oldState, month, element) {
            if (firstMonthToggle) {
                // The very first time the user clicks, erase the selection and set it to one month
                firstMonthToggle = false;
                selectedMonths = [false, false, false, false, false, false, false, false, false, false, false, false]
            }
            selectedMonths[month] = !selectedMonths[month];
            updateSelectedMonths();
        }

        // Rotate the selection across all 12 months
        function rotateSelection() {
            selectedMonths.unshift(selectedMonths.pop());
            updateSelectedMonths();
        }

        function updateSelectedMonths() {
            d3.select("#monthControl").selectAll("g.month")
                .data(selectedMonths);
            d3.selectAll("#monthControl>g>path")
                .attr("class", function (d, i) {
                    return selectedMonths[i] ? "selected" : null
                });
            if (changeCallback) {
                changeCallback(selectedMonths);
            }
        }

        var animationIntervalID = null;

        function toggleAnimation() {
            if (animationIntervalID != null) {
                window.clearInterval(animationIntervalID);
                animationIntervalID = null;
                pause.attr("display", "none");
                play.attr("display", null);
            } else {
                rotateSelection();
                animationIntervalID = window.setInterval(rotateSelection, 1000);
                play.attr("display", "none");
                pause.attr("display", null)
            }
        }

        // Actual installation code
        // Create the SVG element
        d3.selectAll(container)
            .append("svg:svg")
            .attr("width", "150").attr("height", "150")

        // Create a G to hold the whole control
        d3.select("#monthControlDiv>svg")
            .append("svg:g").attr("id", "monthControl")

        // Add a circle as a backdrop
        d3.select("#monthControl").append("svg:circle")
            .attr("class", "backdrop")
            .attr("r", 71.5).attr("transform", "translate(75, 75)")

        // Add a circle in the middle with a Fast Forward icon to act as a central button
        d3.select("#monthControl")
            .append("svg:g")
            .on("click", toggleAnimation)
            .on("touchmove", function () {
                d3.event.preventDefault();
            })
            .on("mousedown", function () {
                d3.event.preventDefault();
            })
            .append("svg:circle")
            .attr("r", 20)
            .attr("class", "center")
            .attr("transform", "translate(75, 75)");

        // Create some button controls as SVG drawings

        // var ffwd = d3.select("#monthControl>g").append("svg:g").attr("transform", "translate(75, 75)");
        // ffwd.append("svg:polygon").attr("points", "-8,-8 -8,8 0,0");
        // ffwd.append("svg:polygon").attr("points", "2,-8 2,8 10,0");

        var play = d3.select("#monthControl>g").append("svg:g").attr("transform", "translate(75, 75)");
        play.append("svg:polygon").attr("points", "-6,-8, -6,8 9,0");

        var pause = d3.select("#monthControl>g").append("svg:g").attr("transform", "translate(75, 75)");
        pause.append("svg:rect").attr("x", -8).attr("y", -8).attr("height", "16").attr("width", "6");
        pause.append("svg:rect").attr("x", 2).attr("y", -8).attr("height", "16").attr("width", "6");
        pause.attr("display", "none")

        // In the control's G, bind our data for selected months and great a bunch of Gs, one per month
        d3.select("#monthControl").selectAll("g.month")
            .data(selectedMonths)
            .enter()
            .append("svg:g")
            .attr("class", "month")

        // For each month, draw a wedge
        d3.selectAll("g.month")
            .attr("transform", "translate(75, 75)")
            .append("svg:path")
            .attr("d", d3.svg.arc()
                .innerRadius(20).outerRadius(70)
                .startAngle(function (d, i) {
                    return i * Math.PI * 2 / 12 - Math.PI * 2 / 24
                })
                .endAngle(function (d, i) {
                    return (i + 1) * Math.PI * 2 / 12 - Math.PI * 2 / 24
                }))
            .attr("class", function (d, i) {
                return selectedMonths[i] ? "selected" : null
            });

        // For each month, draw a label
        d3.selectAll("g.month")
            .append("svg:text")
            .attr("transform", function (d, i) {
                return "rotate(" + (i * 30 - 90) + "), translate(58, 0), rotate(90)"
            })
            .attr("dy", ".35em")
            .text(function (d, i) {
                return ["J", "F", "M", "A", "M", "J", "J", "A", "S", "O", "N", "D"][i]
            });

        // And bind a mouse click handler on the wedge to toggle state
        d3.selectAll("g.month")
            .on("mousedown", function () {
                d3.event.preventDefault();
            })
            .on("touchmove", function () {
                d3.event.preventDefault();
            })
            .on("click", function (d, i) {
                toggleMonth(d, i, d3.select(this));
            });
    }
};