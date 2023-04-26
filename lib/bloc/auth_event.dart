part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class GoogleSignInRequested extends AuthEvent {}

class SignOutRequested extends AuthEvent {}
