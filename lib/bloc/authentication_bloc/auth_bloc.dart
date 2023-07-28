import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../data/repositories/authentication_repository.dart';
import '../../di/locator.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  IAuthenticationRepo authenticationRepo = locator<IAuthenticationRepo>();
  AuthBloc() : super(AuthStateInitial()) {
    on<AuthLoginRequest>((event, emit) async {
      emit(AuthStateLoading());

      var response = await authenticationRepo.login(
        event.username,
        event.password,
      );

      emit(AuthStateLoaded(response));
    });
  }
}
