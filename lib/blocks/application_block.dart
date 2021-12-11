import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pet_health_app/models/place_search.dart';
import 'package:pet_health_app/services/geolocator_service.dart';
import 'package:pet_health_app/services/places_service.dart';

class ApplicationBlock with ChangeNotifier {
  final geoLocatorService = GeolocatorService();
  final placesService = PlacesService();
  // variables
  Position? currentLocation;
  List<PlaceSearch>? searchResults;

  ApplicationBlock() {
    setCurrentLocation();
  }

  setCurrentLocation() async {
    currentLocation = await geoLocatorService.getCurrentLocation();
    notifyListeners();
  }

  searchPlaces(String searchTerm) async {
    searchResults = await placesService.getAutoComplete(searchTerm);
    notifyListeners();
  }
}
