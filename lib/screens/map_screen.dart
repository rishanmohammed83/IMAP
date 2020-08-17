import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:io';

import '../models/place.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isSelected;

  MapScreen(
      {this.initialLocation = const PlaceLocation(
        latitude: 36.5213,
        longitude: -121.8464,
      ),
      this.isSelected = false});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng _pickedLocation;

  void _selectLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Platform.isAndroid
          ? AppBar(
              title: Text('Your Map'),
              actions: [
                if (widget.isSelected)
                  IconButton(
                    icon: Icon(Icons.check),
                    onPressed: _pickedLocation == null
                        ? null
                        : () {
                            Navigator.of(context).pop(_pickedLocation);
                          },
                  )
              ],
            )
          : CupertinoNavigationBar(
              middle: Text('Your Map'),
              trailing: widget.isSelected
                  ? IconButton(
                      icon: Icon(Icons.check),
                      onPressed: _pickedLocation == null
                          ? null
                          : () {
                              Navigator.of(context).pop(_pickedLocation);
                            },
                    )
                  : null,
            ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.initialLocation.latitude,
            widget.initialLocation.longitude,
          ),
          zoom: 16,
        ),
        onTap: widget.isSelected ? _selectLocation : null,
        markers: (_pickedLocation == null && widget.isSelected)
            ? null
            : {
                Marker(
                  markerId: MarkerId('m1'),
                  position: _pickedLocation ??
                      LatLng(
                        widget.initialLocation.latitude,
                        widget.initialLocation.longitude,
                      ),
                ),
              },
      ),
    );
  }
}
