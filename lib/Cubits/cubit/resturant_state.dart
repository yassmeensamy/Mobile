part of 'resturant_cubit.dart';
class ResturantState {}
class ResturantInitial extends ResturantState {}
class ResturanrSucess extends ResturantState
{
      List<Restaurant>restaurants;
      ResturanrSucess(this.restaurants);
}
class ResturantFauiler  extends ResturantState{
  String message;
  ResturantFauiler(this.message);
}
class NavigateToProductScreen extends ResturantState
{
  Restaurant restaurant;
  NavigateToProductScreen(this.restaurant);
}

class ProductsSucess extends ResturantState{
  Restaurant restaurant;
  ProductsSucess(this.restaurant);
}
class ResultSucess extends ResturantState
{
        List<Restaurant>restaurants;
       ResultSucess(this.restaurants);
}
class loading extends ResturantState
{
  
}
class MapLocation extends ResturantState
{
  List<LatLng> markerPoints;
  MapLocation(this.markerPoints);
  
}
