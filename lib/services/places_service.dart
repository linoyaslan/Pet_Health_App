import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:pet_health_app/models/place_search.dart';

class PlacesService {
  final key = 'AIzaSyBoOh5q96QibdvLYOnIVK5xrKm3OB1cBW8';
  Future<List<PlaceSearch>> getAutoComplete(String search) async {
    var url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&types=%28cities%29&key=$key';
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      print("OK");
    } else {
      print("Not Ok");
    }
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['predictions'] as List;
    return jsonResults.map((place) => PlaceSearch.fromJson(place)).toList();
  }
}
