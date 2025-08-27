import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

setStringToPrefs(String key, String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);
}

Future<String?> getStringFromPrefs(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? value = prefs.getString(key);
  return value;
}

setBoolToPrefs(String key, bool value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool(key, value);
}

Future<bool?> getBoolFromPrefs(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? value = prefs.getBool(key);
  return value;
}

getLocationPermession() async {
  // Check if location services are enabled
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return null; // Or handle the case where location services are disabled
  }

  // Check for permissions
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, handle appropriately
      return null; // Or handle the case where permissions are denied
    }
  }
}

class MapUtils {
  MapUtils._();

  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunchUrl(Uri.parse(googleUrl))) {
      await launchUrl(Uri.parse(googleUrl));
    } else {
      throw 'Could not open the map.';
    }
  }
}

/// Helper function to create a color with opacity using modern Flutter approach
Color withOpacity(Color color, double opacity) {
  return Color.fromRGBO(
    (color.r * 255).round(),
    (color.g * 255).round(),
    (color.b * 255).round(),
    opacity,
  );
}
