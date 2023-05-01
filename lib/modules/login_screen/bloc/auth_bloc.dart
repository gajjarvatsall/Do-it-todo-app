import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:doit/modules/login_screen/repository/auth_repository.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  AuthBloc({required this.authRepository}) : super(UnAuthenticated()) {
    on<GoogleSignInRequested>(_onGoogleUserSignIN);
    on<SignOutRequested>(_onUserSignOut);
  }

  void _onGoogleUserSignIN(GoogleSignInRequested event, Emitter<AuthState> emit) async {
    {
      emit(GoogleSignInState(isLoading: true));
      try {
        await authRepository.signInWithGoogle();
        emit(GoogleSignInState(isLoading: false, isCompleted: true));
      } catch (e) {
        emit(GoogleSignInState(hasError: true));
      }
    }
  }

  void _onUserSignOut(SignOutRequested event, Emitter<AuthState> emit) async {
    emit(Loading());
    await authRepository.signOut();
    emit(UnAuthenticated());
  }
}
