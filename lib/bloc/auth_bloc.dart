import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:doit/repository/auth_repository.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  AuthBloc({required this.authRepository}) : super(UnAuthenticated()) {
    on<GoogleSignInRequested>((event, emit) async {
      // emit(Loading());
      emit(GoogleSignInState(isLoading: true));
      try {
        await authRepository.signInWithGoogle();
        // emit(Authenticated());
        emit(GoogleSignInState(isLoading: false, isCompleted: true));
      } catch (e) {
        // emit(AuthError(e.toString()));
        // emit(UnAuthenticated());
        emit(GoogleSignInState(hasError: true));
      }
    });

    on<SignOutRequested>((event, emit) async {
      emit(Loading());
      await authRepository.signOut();
      emit(UnAuthenticated());
    });
  }
}
