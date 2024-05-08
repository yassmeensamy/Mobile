import 'dart:convert';
import 'package:app/Models/ProductModel.dart';
import 'package:app/Models/RestaurantModel.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'resturant_state.dart';

class ResturantCubit extends Cubit<ResturantState> 
{
  List<Restaurant>restaurants=[];
  Set <Product> Products ={};
  List<Restaurant>searchResult=[];
  ResturantCubit() : super(ResturantInitial());
  
  Future<void>FetchResturantData() async
  {
    http.Response response= await http.get(Uri.parse("https://student-affair2.duckdns.org/api/v1/restaurants/"));
    if(response.statusCode==200)
    {
      List<dynamic> data=jsonDecode(response.body);
      restaurants=data.map((item) => Restaurant.fromJson(item)).toList();
  
       for (int i = 0; i < restaurants.length; i++) {
          for (int j = 0; j < restaurants[i].products.length; j++)
           {
                Product product = restaurants[i].products[j];
           if (!Products.any((existingProduct) => existingProduct.id == product.id)) 
           {
                             Products.add(product);
           }
  }
}
      print(Products.length);
      emit(ResturanrSucess(restaurants));
    }
    else 
    {
       emit(ResturantFauiler("Failed"));
    }

  }
  void navigateToProductScreen(String restaurantName) 
  {
     Restaurant? searchedRestaurant = restaurants.firstWhere(
    (restaurant) => restaurant.name ==  restaurantName,
  );
    emit(NavigateToProductScreen(searchedRestaurant));
    emit(ProductsSucess(searchedRestaurant));
  }
  void ResultSearch( int productId) async
  {
    emit(loading());
    String baseUrl = "https://student-affair2.duckdns.org/api/v1/restaurants/by-product/";
    String url = baseUrl + productId.toString() + "/";
    http.Response response= await http.get(Uri.parse(url));
    if(response.statusCode==200)
    {
      List<dynamic> data=jsonDecode(response.body);
      searchResult=data.map((item) => Restaurant.fromJson(item)).toList();
      print(searchResult.length);
      emit(ResultSucess(searchResult));
    }
    else 
    {
        emit(ResturantFauiler("yalhwyyyyyy"));
    }
  }
  void  LocationResultSearch() 
  {
    if(searchResult.isNotEmpty)
    {
       List<LatLng> markerPoints=[];
       for(int i=0 ;i<searchResult.length;i++)
       { 
         LatLng latlng=LatLng(searchResult[i].lat, searchResult[i].long);
         markerPoints.add(latlng);
       }
        emit(MapLocation(markerPoints));
    }
  }
 void clearSearchResults() {
    searchResult = []; // Clear the search result list
    emit(ResturantInitial()); // Emit an initial state or a custom empty state
  }
  
}
