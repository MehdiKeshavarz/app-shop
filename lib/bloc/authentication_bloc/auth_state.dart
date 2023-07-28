part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthStateInitial extends AuthState {}

class AuthStateLoading extends AuthState {}

class AuthStateLoaded extends AuthState {
  final Either<String, String> response;
  AuthStateLoaded(this.response);
}
