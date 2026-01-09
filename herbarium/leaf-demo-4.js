// See post: http://asmaloney.com/2014/01/code/creating-an-interactive-map-with-leaflet-and-openstreetmap/
// https://developer.mapquest.com/sites/default/files/mapquest/try-it-nows/basic/map-layers.html
var mapLayer = MQ.mapLayer(), map;

var map = L.map( 'map', {
//    center: [48.46313, -123.31209],
    layers: mapLayer,
    center: [55.53796, -119.88281],
    minZoom: 2,
    zoom: 4
});

// L.tileLayer( 'http://{s}.mqcdn.com/tiles/1.0.0/map/{z}/{x}/{y}.png', {
//     attribution: '&copy; <a href="http://osm.org/copyright" title="OpenStreetMap" target="_blank">OpenStreetMap</a> contributors | Tiles
// Courtesy of <a href="http://www.mapquest.com/" title="MapQuest" target="_blank">MapQuest</a> <img
// src="http://developer.mapquest.com/content/osm/mq_logo.png" width="16" height="16">',
//    subdomains: ['otile1','otile2','otile3','otile4']
//}).addTo( map );

var myURL = jQuery( 'script[src$="leaf-demo-4.js"]' ).attr( 'src' ).replace( 'leaf-demo-4.js', '' );

var myIcon = L.icon({
    iconUrl: myURL + 'pin24.png',
    iconRetinaUrl: myURL + 'pin48.png',
    iconSize: [29, 24],
    iconAnchor: [9, 21],
    popupAnchor: [0, -14]
});

for ( var i=0; i < markers.length; ++i ) 
{
   L.marker( [markers[i].lat, markers[i].lng], {icon: myIcon} )
      .bindPopup( '<strong>Accession: </strong>' + markers[i].Accession + '<br /> '+ '<strong>Family: </strong>' + markers[i].Family + '<br /> ' + '<strong>Scientific Name: </strong>' + '<i>' + markers[i].ScientificName + '</i>' + '<br />' + '<strong>Locality: </strong>' + markers[i].Locality + '<br />' + markers[i].GeoSecondary + ' ' + markers[i].GeoPrimary)
      .addTo( map );
}