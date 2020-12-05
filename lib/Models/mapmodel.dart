

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:geocoder/geocoder.dart';
//import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapModel with ChangeNotifier{
  var getit;
  getLocation(LatLng attr) async
      {
        var addresses;
          double latitude = attr.latitude;
          double longitude = attr.longitude;
        try{
         final coordinates = new Coordinates(latitude, longitude);
         addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
        }
        catch(e){
          print('error in getting your picked location');
        }
        getit = addresses;
        notifyListeners();
      }

      getCurrentLocation() async{
        var addresses;
        /*try{
          
        Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        final coordinates = new Coordinates(position.latitude, position.longitude);
        addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
        }
        catch(e){
          print('error in getting your current location :' + e.toString());
        }


        getit = addresses.first;
        */

      LocationData myLocation;
      String error;
      Location location = new Location();
      try {
        myLocation = await location.getLocation();
      } on PlatformException catch (e) {
        if (e.code == 'PERMISSION_DENIED') {
          error = 'please grant permission';
          print(error);
        }
        if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
          error = 'permission denied- please enable it from app settings';
          print(error);
        }
        myLocation = null;
      }
      //currentLocation = myLocation;
      final coordinates = new Coordinates(
      myLocation.latitude, myLocation.longitude);
      addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
      getit = addresses;
      notifyListeners();
      }
}