import 'package:app/Cubits/cubit/location_cubit.dart';
import 'package:app/Cubits/cubit/resturant_cubit.dart';
import 'package:app/Models/RestaurantModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StoreCard extends StatelessWidget {
  final Restaurant store;

  StoreCard({required this.store});
  @override
  Widget build(BuildContext context) {
     
      double distance = BlocProvider.of<LocationCubit>(context).calculateDistance(store.lat,store.long);
        return InkWell(
      onTap: () 
      {  
         BlocProvider.of<ResturantCubit>(context).navigateToProductScreen(store.name);
      },
      child:Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 120,
                  height: 80,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black.withOpacity(.3),
                      width: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(10),
                 image: DecorationImage(
  fit: BoxFit.cover,
  image: NetworkImage(store.image),
),

                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(store.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                          IconButton(
                            icon: Icon( Icons.favorite_border, color: Colors.orange),
                            onPressed: () {
                            }
                          ),
                        ],
                      ),
                      Text("store.description", style: TextStyle(color: Colors.black.withOpacity(.6), fontSize: 14)),
                      Padding(padding: EdgeInsets.only(right: 8),
                      child:
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         Row(
                        children: [
                          Icon(Icons.star, color: Colors.yellow),
                          Text(store.rating.toString()),
                        ],
                      ),
                      Container(
                              margin: EdgeInsets.only(top:4),
                               width: 100,
                                height: 27,
                              decoration: BoxDecoration(
                              color: Colors.orange,  // Assuming dountscolor is declared and defined elsewhere
                               borderRadius: BorderRadius.circular(15
                            
                                 ),
                              ),
        
                                          child: Center(
                                         child:
                                         Padding(padding: EdgeInsets.only(top:6,bottom: 6,right: 3,left: 3),child:
                                         //Text(distance.toString()+" km",style: TextStyle(color: Colors.white),),

                                         Text(distance.toString()+" km",style: TextStyle(color: Colors.white),),
                                           ),
                                          ),
                      )
                      ],
                     )
                      )
                    ],
  
                  ),
                ),
              ],
            ),
          ),
        ),
        );
      }
  }

