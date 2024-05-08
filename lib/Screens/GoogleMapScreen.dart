import 'dart:async';

import 'package:app/Cubits/cubit/location_cubit.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Import Bloc library

// Assuming you have a LocationCubit defined somewhere in your app

class GoogleMapPage extends StatefulWidget 
  {
     List<LatLng> markerPoints;
     GoogleMapPage({required this.markerPoints});

  @override
  State<GoogleMapPage> createState() => _GoogleMapPageState(markerPoints: markerPoints);
}

class _GoogleMapPageState extends State<GoogleMapPage> {
       List<LatLng> markerPoints ;
       List<Marker>markers=[];
         _GoogleMapPageState({required this.markerPoints});
       GoogleMapController? gmc;
        void addMarkersFromPoints()
        {
                      int id=1;
                      markerPoints.forEach((point) 
                {
                        MarkerId markerId = MarkerId(id.toString());
                           Marker newMarker = Marker(
                            markerId: markerId,
                             position: point,
                                   );
                           markers.add(newMarker);
                           id++;
               });
}
  @override
  void initState() {
    super.initState();
    addMarkersFromPoints();
  }

  @override
  Widget build(BuildContext context) {
    // Accessing the LocationCubit instance
    final currentPosition = BlocProvider.of<LocationCubit>(context).currentPosition;
    CameraPosition _kGooglePlex = CameraPosition(
    target:markerPoints[0],
    zoom: 14.4746,
  );

    return GoogleMap(
        markers: markers.toSet(),
        //mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) 
        {
          gmc=controller;  
        },
       );
  }
}
