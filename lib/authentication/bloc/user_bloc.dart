import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:msf/data/model/AppUser.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    _listenToAuthStateChanges();
  }

  AppUser? _appUser;
  AppUser? get appUser => _appUser;

  StreamSubscription? _loginStateChangeSubscription;

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is LogoutEvent) {
      yield UserLoadingState();
      _appUser = null;
      yield UserUnAuthenticatedState();
    }
  }

  void _listenToAuthStateChanges() {
    _loginStateChangeSubscription =
        FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User logged out');
        add(LogoutEvent());
      } else {
        print('User logged in');
      }
    });
  }

  void _loginWithEmailPass(String email, String password) {}

  @override
  Future<void> close() {
    _loginStateChangeSubscription?.cancel();
    return super.close();
  }
}
