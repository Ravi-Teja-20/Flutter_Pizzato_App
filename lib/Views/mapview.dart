

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pizzato_app/Models/mapmodel.dart';
import 'package:provider/provider.dart';

class MapView extends StatefulWidget {
  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  
  LatLng currentLocation = LatLng(17.3850,78.4867);
  var loc;
  var coord;

  @override
  void initState() {
    super.initState();
  }

  void getMarkerLocation(Coordinates coordinates) async{

  }

      List<Marker> mymarkers = [];

     void addMarker(LatLng coordinates) async{
       double latitude = coordinates.latitude;
       double longitude = coordinates.longitude;
       final coord = new Coordinates(latitude, longitude);
       loc = await Geocoder.local.findAddressesFromCoordinates(coord);
      Provider.of<MapModel>(context, listen: false).getLocation(coordinates);
      setState(() {
        mymarkers = [];
        //final markerId = coordinates.toString();
        mymarkers.add(Marker(
          position: coordinates, 
          markerId: MarkerId('0'),
          infoWindow: InfoWindow(
          title: loc.first.addressLine
          ),
          ),
        );
      });
    }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Pick Your Location', style: TextStyle(color: Colors.white, fontSize: 25, fontStyle: FontStyle.normal, fontWeight: FontWeight.w700),),
      ),
      body: GoogleMap(
      initialCameraPosition: CameraPosition(target: currentLocation, zoom: 14),
      mapType: MapType.hybrid,
      markers: Set.from(mymarkers),
      myLocationButtonEnabled: true,
      onTap: addMarker,
         ),
    );
  }
}