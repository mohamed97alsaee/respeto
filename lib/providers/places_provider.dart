import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

class PlacesProvider with ChangeNotifier {
  bool busy = false;
  bool failed = false;

  final _places =
      GoogleMapsPlaces(apiKey: 'AIzaSyBWrA2IKsMHVpOIXF7H08sYb9aoy_QARTc');

  List<PlacesSearchResult> placesList = [];

  LatLng? currentPosition;
  setBusy(bool value) {
    Timer(Duration(milliseconds: 50), () {
      busy = value;
      notifyListeners();
    });
  }

  setFailed(bool value) {
    Timer(Duration(milliseconds: 50), () {
      failed = value;
      notifyListeners();
    });
  }

  Future searchPlaces(
    String query,
  ) async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setBusy(true);

    final result = await _places.searchNearbyWithRadius(
      Location(lat: position.latitude, lng: position.longitude),
      5000,
      type: "restaurant",
      keyword: query,
    );
    if (result.status == "OK") {
      print(result.results);
      placesList = result.results;
      setFailed(false);

      setBusy(false);
    } else {
      setFailed(true);

      setBusy(false);

      throw Exception(result.errorMessage);
    }
  }
}
