import 'package:app/Screens/GoogleMapScreen.dart';
import 'package:app/Screens/ResturandScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/Cubits/cubit/resturant_cubit.dart';
import 'package:app/Models/RestaurantModel.dart';
import 'package:app/Screens/Screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 40),
            child: Container(
              height: 50, // Example height, adjust as needed
              child: Search(), // Assuming Search() is a custom widget
            ),
          ),
          Expanded(
            child: BlocConsumer<ResturantCubit, ResturantState>(
              listener: (context, state) {
                // Handle state changes if needed
              },
              builder: (context, state) 
              {
                if (state is ResultSucess) 
                {
                  List<Restaurant> restaurants = state.restaurants;
                  return ResultWithGPs(restaurants);
                } 
                else if(state is loading)
                {
                  return Center(child: CircularProgressIndicator());
                }
                else if (state is MapLocation)
                {
                 
                  return  GoogleMapPage(markerPoints:state.markerPoints,);
                  //LocationState(markerPoints: state.markerPoints,);
                }
                else 
                {
                  return Container(color: Colors.white,);
                  //Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ResultWithGPs extends StatelessWidget {
  final List<Restaurant> restaurants;

  ResultWithGPs(this.restaurants);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: RestaurantList(restaurants: restaurants),
        ),
        Padding(padding: 
        EdgeInsets.only(bottom: 100),
        child:TextButton(onPressed: ()
        {
            BlocProvider.of<ResturantCubit>(context).LocationResultSearch();
        },
         child:Text("Change View as Map") ),
        )
      ],
    );
  }
}
