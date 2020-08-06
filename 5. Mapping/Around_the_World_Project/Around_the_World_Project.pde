import de.fhpotsdam.unfolding.*;
import de.fhpotsdam.unfolding.data.*;
import de.fhpotsdam.unfolding.geo.*;
import de.fhpotsdam.unfolding.marker.*;
import de.fhpotsdam.unfolding.utils.*;
import java.util.*;


  

import java.util.HashMap;
import java.util.List;

import processing.core.PApplet;
import de.fhpotsdam.unfolding.UnfoldingMap;
import de.fhpotsdam.unfolding.data.Feature;
import de.fhpotsdam.unfolding.data.GeoJSONReader;
import de.fhpotsdam.unfolding.marker.Marker;
import de.fhpotsdam.unfolding.utils.MapUtils;



UnfoldingMap map;
List countryMarkers = new ArrayList();
Place[] countriesData;
color markContinent = color(94,33,41);
Travel trip1;
Travel trip2;
Travel trip3;

void setup() {
  fill(0,255,100);
  size(800, 800, P2D); //fix size according to images
  
  countriesData = new Place[4];
  countriesData[0] = new Place("Yunnan", "China",new Location(24.4753, 101.3431), loadImage("carina.png"));
  countriesData[1] = new Place("Quezon City", "Philippines", new Location(14.6760, 121.0437), loadImage("cj.png"));
  countriesData[2] = new Place("Berlin", "Germany", new Location(52.5200, 13.4050), loadImage("adib.png"));
  countriesData[3] = new Place("Tartu", "Estonia", new Location(58.3780, 26.7290), loadImage("toomas.png"));

  map = new UnfoldingMap(this);
  MapUtils.createDefaultEventDispatcher(this, map);
 
  List<Feature> countries = GeoJSONReader.loadData(this, "countries.geo.json");
  List<Marker> countryMarkers = MapUtils.createSimpleMarkers(countries);
  map.addMarkers(countryMarkers);
  for (Marker marker : countryMarkers){
    marker.setColor(255);
    marker.setStrokeColor(markContinent);
  }
}

void draw(){
  background(markContinent);
  map.draw();
  for (Place place: countriesData){
    ScreenPosition pos = map.getScreenPosition(place.loc);
    fill(0);
    noStroke();
    ellipse(pos.x, pos.y, 10,10);
  }
  trip1 = new Travel(countriesData[0].loc, countriesData[1].loc);
  trip1.display();
  trip2 = new Travel(countriesData[1].loc, countriesData[2].loc);
  trip2.display();
  trip3 = new Travel(countriesData[2].loc, countriesData[3].loc);
  trip3.display();
}

