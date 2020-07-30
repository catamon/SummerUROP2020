/**
 * Loads country markers, and highlights a polygon when the user hovers over it.
 * 
 * This example starts in Southeast Asia to demonstrate hovering multi-marker polygons
 * such as Indonesia, Phillipines, etc.
 */

import de.fhpotsdam.unfolding.*;
import de.fhpotsdam.unfolding.data.*;
import de.fhpotsdam.unfolding.geo.*;
import de.fhpotsdam.unfolding.marker.*;
import de.fhpotsdam.unfolding.utils.*;
import java.util.*;

UnfoldingMap map;
List countryMarkers = new ArrayList();
Location mexicoCity = new Location(19.411312, -99.102534);

void setup() {
  size(800, 600, P2D);

  map = new UnfoldingMap(this);
  map.zoomAndPanTo(mexicoCity, 3);
  MapUtils.createDefaultEventDispatcher(this, map);

  List countries = GeoJSONReader.loadData(this, "countries.geo.json");
  List countryMarkers = MapUtils.createSimpleMarkers(countries);
  map.addMarkers(countryMarkers);
}

void draw() {
  background(240);
  map.draw();

  // Shows marker at Berlin location
  Location loc = new Location(19.411312, -99.102534);
  ScreenPosition pos = map.getScreenPosition(loc);
  fill(0);
  ellipse(pos.x, pos.y, 5, 5);
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
