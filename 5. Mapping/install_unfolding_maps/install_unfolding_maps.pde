import de.fhpotsdam.unfolding.*;
import de.fhpotsdam.unfolding.data.*;
import de.fhpotsdam.unfolding.geo.*;
import de.fhpotsdam.unfolding.marker.*;
import de.fhpotsdam.unfolding.utils.*;
import java.util.*;

Place[] countriesData;


UnfoldingMap map;
List countryMarkers = new ArrayList();

// Location paris = new Location(48.8566, 2.3522);







void setup() {
  size(800, 600, P2D);
  
  countriesData = new Place[10];
  countriesData[0] = new Place("Paris", "France",new Location(48.8566, 2.3522), loadImage("paris.jpg"));
  countriesData[1] = new Place("Rio de Janeiro", "Brazil", new Location(-22.9068, -43.1729), loadImage("rio.jpg"));
  countriesData[2] = new Place("Boston", "United States of America", new Location(42.3601, -71.0589), loadImage("boston.jpg"));
  countriesData[3] = new Place("Guatape", "Colombia", new Location(6.2338, -75.1592), loadImage("guatape.jpg"));
  countriesData[4] = new Place("Cape Town", "South Africa", new Location(-33.9249, 18.4241), loadImage("capeTown.jpg"));
  countriesData[5] = new Place("Yamaguchi", "Japan", new Location(34.1783, 131.4738), loadImage("yamaguchi.jpg"));
  countriesData[6] = new Place("Abu Dhabi", "United Arab Emirates", new Location(24.4539, 54.3773), loadImage("abuDhabi.jpg"));
  countriesData[7] = new Place("Cancun", "Mexico", new Location(21.1619, -86.8515), loadImage("cancun.jpg"));
  countriesData[8] = new Place("Santiago", "Spain", new Location(42.8782, -8.5448), loadImage("santiago.jpg"));
  countriesData[9] = new Place ("Palawan", "Philippines", new Location(9.8349, 118.7384), loadImage("palawan.jpg"));
  map = new UnfoldingMap(this);
  map.zoomAndPanTo(countriesData[0].loc, 3);
  MapUtils.createDefaultEventDispatcher(this, map);

  List countries = GeoJSONReader.loadData(this, "countries.geo.json");
  List countryMarkers = MapUtils.createSimpleMarkers(countries);
  map.addMarkers(countryMarkers);
  ScreenPosition pos = map.getScreenPosition(countriesData[0].loc);
}

void draw() {
  background(240);
  map.draw();

  // Shows marker at every location
  for (int i = 0; i < 10; i++){
   ScreenPosition pos = map.getScreenPosition(countriesData[i].loc);
   stroke(1);
   fill(255);
   ellipse(pos.x, pos.y, 10, 10);
    float diff = dist(pos.x, pos.y, mouseX, mouseY);
    if (diff < 25){
      countriesData[i].display(pos.x, pos.y);
    }
  }
}


void mouseMoved() {
  // Deselect all marker
  for (Marker marker : map.getMarkers()) {
    marker.setSelected(false);
  }

  // Select hit marker
  // Note: Use getHitMarkers(x, y) if you want to allow multiple selection.
  Marker marker = map.getFirstHitMarker(mouseX, mouseY);
  if (marker != null) {
    marker.setSelected(true);
  }
}


