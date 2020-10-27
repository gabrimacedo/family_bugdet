import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this.repository) : super(UnknowState()) {
    _userSubscription = repository.userStream().listen((user) {
      add(AuthUserChanged(user));
    });
  }

  final AuthRepository repository;
  StreamSubscription<User> _userSubscription;

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AuthUserChanged) {
      yield _mapAuthUserChangedToState(event);
    } else if (event is AuthLogoutRequested) {
      repository.signOutUser();
    }
  }

  AuthState _mapAuthUserChangedToState(AuthUserChanged event) {
    return (event.user == null) ? LoggedOutState() : LoggedInState(event.user);
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}
