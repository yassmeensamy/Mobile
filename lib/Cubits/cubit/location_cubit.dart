import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> 
{
  LocationCubit() : super(LocationInitial());

  Position? _currentPosition;
  Position? get currentPosition => _currentPosition;
  Future<void> getCurrentLocation() async {
    try {
      emit(LocationLoading());
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        emit(LocationError());
       
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          emit(LocationError());
         
        }
      }
      if (permission == LocationPermission.whileInUse) {
        Position position = await Geolocator.getCurrentPosition();
        _currentPosition = position;
        emit(LocationLoaded());
      } 
      else
       {
        emit(LocationError());
      }
    } 
    catch (e) {
      emit(LocationError());
    }
  }

  bool isLocationAvailable() {
    return _currentPosition != null;
  }

  double calculateDistance(double long, double lat) {
    if (_currentPosition == null) {
      throw Exception("Current location is not available.");
      // Or return a default value, e.g., return 0.0;
    }
    double distanceInMeters = Geolocator.distanceBetween(
        _currentPosition!.latitude, _currentPosition!.longitude, lat, long);
    double distanceInKilometers = distanceInMeters / 1000; // Convert meters to kilometers
    return double.parse(distanceInKilometers.toStringAsFixed(2));
  }
}
