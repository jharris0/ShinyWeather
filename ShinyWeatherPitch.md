ShinyWeather Web App Pitch Deck
========================================================
author: Jesse Harris
date: August 13, 2017
autosize: true
font-import: http://fonts.googleapis.com/css?family=Lora
font-family: 'Lora'

The Concept
========================================================

<style>
.slideContent p, .slideContent ul {
        font-size:80%;
}

.small-code pre code {
  font-size: 1.1em;
}
</style>

- People like to know the weather.
- Our web app, called **ShinyWeather,** will display the weather.
- It will pull data from the Weather Underground API and display it using Shiny.
- Once we get enough users, we will put ads on it.

***

![Alpha version of ShinyWeather](ShinyWeather_Screenshot.png)

Technical Details
========================================================
class: small-code

When a user submits a location, we use `reactiveValues` and `observeEvent` to
trigger an API call using the rwunderground package. Within a Shiny Dashboard
framework, we display the data using Shiny elements and embedded googleVis
charts. Here is a code example:






```r
Area <- gvisAreaChart(forecast,
                       xvar = "date",
                       yvar = c("temp"),
                       options = list(
                               legend = "none",
                               width = 500,
                               height = 380,
                               vAxis = "{title: 'temperature (°C)'}",
                               vAxes = "[{viewWindowMode:'explicit',viewWindow:{min:0, max:45}}]"
                        )
)
```

Technical Details (Cont'd)
========================================================
class: small-code

And if we plot the object from the previous slide, we get the following visualization based on the Google Charts API.




```r
plot(Area)
```

<!-- AreaChart generated in R 3.4.1 by googleVis 0.6.2 package -->
<!-- Tue Aug 22 20:11:14 2017 -->


<!-- jsHeader -->
<script type="text/javascript">
 
// jsData 
function gvisDataAreaChartID10c016867e07 () {
var data = new google.visualization.DataTable();
var datajson =
[
 [
"2017-08-13 01:00:00",
16
],
[
"2017-08-13 02:00:00",
16
],
[
"2017-08-13 03:00:00",
16
],
[
"2017-08-13 04:00:00",
17
],
[
"2017-08-13 05:00:00",
15
],
[
"2017-08-13 06:00:00",
14
],
[
"2017-08-13 07:00:00",
13
],
[
"2017-08-13 08:00:00",
13
],
[
"2017-08-13 09:00:00",
13
],
[
"2017-08-13 10:00:00",
13
],
[
"2017-08-13 11:00:00",
13
],
[
"2017-08-13 12:00:00",
12
],
[
"2017-08-13 13:00:00",
12
],
[
"2017-08-13 14:00:00",
13
],
[
"2017-08-13 15:00:00",
14
],
[
"2017-08-13 16:00:00",
14
],
[
"2017-08-13 17:00:00",
16
],
[
"2017-08-13 18:00:00",
16
],
[
"2017-08-13 19:00:00",
17
],
[
"2017-08-13 20:00:00",
17
],
[
"2017-08-13 21:00:00",
18
],
[
"2017-08-13 22:00:00",
18
],
[
"2017-08-13 23:00:00",
18
],
[
"2017-08-14 00:00:00",
18
],
[
"2017-08-14 01:00:00",
17
],
[
"2017-08-14 02:00:00",
16
],
[
"2017-08-14 03:00:00",
16
],
[
"2017-08-14 04:00:00",
16
],
[
"2017-08-14 05:00:00",
14
],
[
"2017-08-14 06:00:00",
14
],
[
"2017-08-14 07:00:00",
14
],
[
"2017-08-14 08:00:00",
14
],
[
"2017-08-14 09:00:00",
14
],
[
"2017-08-14 10:00:00",
13
],
[
"2017-08-14 11:00:00",
14
],
[
"2017-08-14 12:00:00",
13
] 
];
data.addColumn('string','date');
data.addColumn('number','temp');
data.addRows(datajson);
return(data);
}
 
// jsDrawChart
function drawChartAreaChartID10c016867e07() {
var data = gvisDataAreaChartID10c016867e07();
var options = {};
options["allowHtml"] = true;
options["legend"] = "none";
options["width"] = 500;
options["height"] = 380;
options["vAxis"] = {title: 'temperature (°C)'};
options["vAxes"] = [{viewWindowMode:'explicit',viewWindow:{min:0, max:45}}];

    var chart = new google.visualization.AreaChart(
    document.getElementById('AreaChartID10c016867e07')
    );
    chart.draw(data,options);
    

}
  
 
// jsDisplayChart
(function() {
var pkgs = window.__gvisPackages = window.__gvisPackages || [];
var callbacks = window.__gvisCallbacks = window.__gvisCallbacks || [];
var chartid = "corechart";
  
// Manually see if chartid is in pkgs (not all browsers support Array.indexOf)
var i, newPackage = true;
for (i = 0; newPackage && i < pkgs.length; i++) {
if (pkgs[i] === chartid)
newPackage = false;
}
if (newPackage)
  pkgs.push(chartid);
  
// Add the drawChart function to the global list of callbacks
callbacks.push(drawChartAreaChartID10c016867e07);
})();
function displayChartAreaChartID10c016867e07() {
  var pkgs = window.__gvisPackages = window.__gvisPackages || [];
  var callbacks = window.__gvisCallbacks = window.__gvisCallbacks || [];
  window.clearTimeout(window.__gvisLoad);
  // The timeout is set to 100 because otherwise the container div we are
  // targeting might not be part of the document yet
  window.__gvisLoad = setTimeout(function() {
  var pkgCount = pkgs.length;
  google.load("visualization", "1", { packages:pkgs, callback: function() {
  if (pkgCount != pkgs.length) {
  // Race condition where another setTimeout call snuck in after us; if
  // that call added a package, we must not shift its callback
  return;
}
while (callbacks.length > 0)
callbacks.shift()();
} });
}, 100);
}
 
// jsFooter
</script>
 
<!-- jsChart -->  
<script type="text/javascript" src="https://www.google.com/jsapi?callback=displayChartAreaChartID10c016867e07"></script>
 
<!-- divChart -->
  
<div id="AreaChartID10c016867e07" 
  style="width: 500; height: 380;">
</div>

Wrap-Up
========================================================

It doesn't look like much yet, but we are working on a number of improvements, such as:

- Allow users to check weather for their own location, not just the four novelty locations currently shown.
- Better yet, get the user's current location and look up weather conditions automatically.
- Drop googleVis in favour of something easier to work with, maybe Plotly or something.

### Credit

This page was especially helpful in building this app:
 
- http://www.alshum.com/shiny-reactive/
