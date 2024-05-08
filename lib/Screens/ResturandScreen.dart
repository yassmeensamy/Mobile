import 'package:app/Cubits/cubit/location_cubit.dart';
import 'package:app/Cubits/cubit/resturant_cubit.dart';
import 'package:app/Models/RestaurantModel.dart';
import 'package:app/Screens/ProductsScreen.dart';
import 'package:app/Screens/SearchScreen.dart';
import 'package:app/Widgets/StoreCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Import flutter_bloc package

class ResturantScreen extends StatelessWidget {
  const ResturantScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Restaurant> restaurants = [];
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 30,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.person, color: Colors.orange),
          onPressed: () {
            print('Leading icon pressed');
          },
          iconSize: 30,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.orange),
            onPressed: () async {
              BlocProvider.of<ResturantCubit>(context, listen: false)
                  .clearSearchResults();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchScreen()),
              );
            },
            iconSize: 23,
          ),
        ],
      ),
      backgroundColor: Colors.white.withOpacity(.97),
      body: BlocBuilder<LocationCubit, LocationState>(
        builder: (context, locationState) 
        {
           if (locationState is LocationLoading)
           {
            return Center(child: CircularProgressIndicator());
            } 
          else if (locationState is LocationLoaded) 
          {
            final currentPosition =context.read<LocationCubit>().currentPosition;
             print(currentPosition!.latitude);
             print(currentPosition!.longitude);
                    
             BlocProvider.of<ResturantCubit>(context)..FetchResturantData();
              return BlocConsumer<ResturantCubit, ResturantState>
              (
                listener: (context, state) 
                {
                  if (state is NavigateToProductScreen) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProductsScreen()),
                    );
                  }
                },
                builder: (context, state) 
                {
                  
                  if (state is ResturanrSucess)
                  
                    restaurants = state.restaurants;
                    return RestaurantList(restaurants: restaurants);
                  /*
                  }
                  
                  else 
                  {
                    print(state.runtimeType);
                    return Container(color: Colors.blue,);
                  }
                  */
                } 

              );
            } 
             
            else 
              {
                 print(locationState.runtimeType);
                return Container(color: Colors.black,);
              }
              
          } 
         
       
      ),
    );
  }
}

class RestaurantList extends StatelessWidget {
      List<Restaurant>restaurants;
       RestaurantList({ required this.restaurants});

  @override
  Widget build(BuildContext context) {
    return  Padding(
            padding: EdgeInsets.only(top: 10, right: 8, left: 8),
            child: ListView.builder(
              itemCount: restaurants.length, 
              itemBuilder: (context, index) {
                return StoreCard(
                  store:
                   restaurants[index],
                ); 
              },
            ),
          );
  }
}

