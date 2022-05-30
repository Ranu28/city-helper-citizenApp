import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_login_ui/providers/location.dart';
import 'package:flutter_login_ui/screens/notification/notification_screen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
// import 'package:google_maps/google_maps.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> _controller = Completer();
  static const _initialCameraPosition = CameraPosition(
      target: LatLng(6.6292279597855455, 80.23596872705231), zoom: 11.5);
  // 6.6292279597855455, 80.23596872705231
  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  late final GoogleMapController _gooleMapController;
  Marker? _origin;
  Marker? _selectLocation;
  @override
  void dispose() {
    // TODO: implement dispose
    _gooleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Location"),
        backgroundColor: HexColor('#75b9e6'),
        actions: [
          Container(
              margin: EdgeInsets.only(right: 20),
              child: IconButton(
                  onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => NotificationScreen()),
                      ),
                  icon: Icon(Icons.notifications_outlined)))
        ],
      ),
      body: Column(
        children: [
          Container(
            // margin: EdgeInsets.only(bottom: 90),
            height: size.height * 0.78,
            child: GoogleMap(
              // padding: EdgeInsets.only(bottom: 20),
              onMapCreated: (controller) => _gooleMapController = controller,
              initialCameraPosition: _initialCameraPosition,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: true,
              zoomGesturesEnabled: true,
              markers: {
                // if (_origin != null) _origin!,
                if (_selectLocation != null) _selectLocation!,
              },
              onTap: _addMarker,
              mapType: MapType.normal,
            ),
          ),
          Expanded(
            child: Center(
              child: InkWell(
                onTap: () {
                  // Position newPos = new Position(longitude: _origin!.position.longitude, latitude: _origin!.position.latitude);

                  print("${_selectLocation!.position.latitude}");
                  print("${_selectLocation!.position.longitude}");

                  Provider.of<MakeComplainant>(context, listen: false)
                      .setPosition(_selectLocation!.position.latitude,
                          _selectLocation!.position.longitude);

                  Navigator.of(context).pop();
                },
                child: Container(
                  // margin: EdgeInsets.,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: Text(
                    "Set Location",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  decoration: BoxDecoration(
                      color: HexColor('#75b9e6'),
                      borderRadius: BorderRadius.circular(50)),
                ),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Position position = await _currentPossioton();

          _gooleMapController.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                  target: LatLng(position.latitude, position.longitude),
                  zoom: 11.5),
            ),
          );

          Marker nowMarker = Marker(
              markerId: MarkerId('currentLocaton'),
              position: LatLng(position.latitude, position.longitude));

          setState(() {
            _selectLocation = nowMarker;
          });
        },
        child: Icon(Icons.location_city),
      ),
    );
  }

  Future<Position> _currentPossioton() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location service ae disabled');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Location Permission denied");
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location Permission are permanently denied');
    }

    Position position = await Geolocator.getCurrentPosition();

    return position;
  }

  void _addMarker(LatLng pos) {
    // if (_selectLocation != null) {
    setState(() {
      _selectLocation = Marker(
        markerId: const MarkerId('origin'),
        infoWindow: const InfoWindow(title: 'origin'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        position: pos,
      );
      // _destination = null;
    });
    // }
    // else {
    //   setState(() {
    //     _destination = Marker(
    //       markerId: const MarkerId('destination'),
    //       infoWindow: const InfoWindow(title: 'destination'),
    //       icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    //       position: pos,
    //     );
    //     // _destination = null;
    //   });
    // }
  }
}
