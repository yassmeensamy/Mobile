part of 'location_cubit.dart';

@immutable
sealed class LocationState {}

final class LocationInitial extends LocationState {}
class LocationLoading extends LocationState {}
class LocationLoaded extends LocationState {}
class LocationError extends LocationState {}