part of 'log_in_cubit.dart';

@immutable
sealed class LogInState {}

final class LogInInitial extends LogInState {}

final class LogInloading extends LogInState {}

final class LogInSuccess extends LogInState {
  final String message;
  LogInSuccess( this.message);
}

final class LogInFailer extends LogInState {
    final String error;

  LogInFailer(this.error);
}