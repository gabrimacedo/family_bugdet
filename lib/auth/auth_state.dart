part of 'auth_bloc.dart';

class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class UnknowState extends AuthState {}

class LoggedOutState extends AuthState {}

class LoggedInState extends AuthState {
  const LoggedInState(this.user);

  final User user;

  @override
  List<Object> get props => [user];
}
