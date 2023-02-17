import 'package:flutter/material.dart';
import 'package:food_app_complete/constant/colors.dart';
import 'package:food_app_complete/providers/check_out_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class CustomGoogleMap extends StatefulWidget {
  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  LatLng _intitialcamerapositon = LatLng(20.597, 78.9629);
  Set<Marker> markers = Set();

  Location location = Location();
  GoogleMapController? controller;

  void _onMapCreated(GoogleMapController value) {
    controller = value;
    location.onLocationChanged.listen((event) {
      controller!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(
              double.parse(event.latitude.toString()),
              double.parse(event.longitude.toString()),
            ),
            zoom: 20,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    CheckOutProvider checkOutProvider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        backgroundColor: primaryColor,
        title: Text(
          'Google Map Adress',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: _intitialcamerapositon,
              ),
              mapType: MapType.hybrid,
              onMapCreated: _onMapCreated,
              myLocationEnabled: true,
              mapToolbarEnabled: true,
              markers: {
                Marker(
                  markerId: MarkerId('Location'),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueRed,
                  ),
                ),
              },
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 50,
                width: double.infinity,
                margin:
                    EdgeInsets.only(left: 10, right: 60, top: 40, bottom: 40),
                child: MaterialButton(
                  onPressed: () async {
                    await location.getLocation().then((value) {
                      setState(() {
                        checkOutProvider.setLocation = value;
                      });
                    });
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Set Location',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  color: primaryColor,
                  shape: StadiumBorder(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
