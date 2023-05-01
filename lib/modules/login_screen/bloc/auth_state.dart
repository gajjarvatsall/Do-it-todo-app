part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class Loading extends AuthState {
  @override
  List<Object?> get props => [];
}

class GoogleSignInState extends AuthState {
  bool isCompleted;
  bool isLoading;
  bool hasError;
  GoogleSignInState({this.isCompleted = false, this.isLoading = false, this.hasError = false});
}

class Authenticated extends AuthState {
  @override
  List<Object?> get props => [];
}

class UnAuthenticated extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthError extends AuthState {
  final String error;

  AuthError(this.error);
  @override
  List<Object?> get props => [error];
}
