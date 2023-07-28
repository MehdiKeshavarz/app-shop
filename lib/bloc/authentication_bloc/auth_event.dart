part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class AuthLoginRequest extends AuthEvent {
  final String username;
  final String password;

  AuthLoginRequest(this.username, this.password);
}
