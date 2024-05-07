import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class LocationState extends StatefulWidget 
{ 
   List<LatLng> markerPoints;
   LocationState({required this.markerPoints});

  @override
  State<LocationState> createState() => __LocationStateState(markerPoints: markerPoints);
}


class __LocationStateState extends State<LocationState> {
  List<LatLng> markerPoints ;
  __LocationStateState({required this.markerPoints});

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: markerPoints[0], // Default initial center
        initialZoom: 11,
        interactionOptions: const InteractionOptions(flags: ~InteractiveFlag.doubleTapDragZoom),
      ),
      children: [
        openStreetMapTileLayer,
        MarkerLayer(
          markers: markerPoints
              .map((point) => Marker(point: point, child: Icon(Icons.location_pin)))
              .toList(),
        ),
      ],
    );
  }
}

TileLayer get openStreetMapTileLayer => TileLayer(
      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
      userAgentPackageName: 'dev',
    );



