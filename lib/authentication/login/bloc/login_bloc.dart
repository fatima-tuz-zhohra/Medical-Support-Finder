import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:msf/data/constant.dart';
import 'package:msf/services/database.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginWithEmailPassEvent) {
      yield LoginLoadingState();
      final result = await _loginWithEmailPass(event.email, event.pass);
      if (result == true) {
        yield LoginSuccessState();
      } else {
        yield LoginFailedState();
      }
    } else if (event is LoginWithGoogleEvent) {
      yield LoginLoadingState();
      final result = await _logInWithGoogle();
      if (result == true) {
        yield LoginSuccessState();
      } else {
        yield LoginFailedState();
      }
    }
  }

  Future<bool> _loginWithEmailPass(String email, String password) async {
    try {
    final cd = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = cd.user!;

      final db = DatabaseService(uid: user.uid);
      final isExistingUser = await db.isExistingUser();
      if (!isExistingUser) {
        db.updateUserData(user.displayName ?? '', user.phoneNumber ?? '',
            user.email ?? '', RolesConstants.user,  user.photoURL ?? '');
      }
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      return false;
    }
  }

  Future<bool> _logInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    try {
      // Once signed in, return the UserCredential
      final cd = await FirebaseAuth.instance.signInWithCredential(credential);
      final user = cd.user!;

      final db = DatabaseService(uid: user.uid);
      final isExistingUser = await db.isExistingUser();
      if (!isExistingUser) {
        db.updateUserData(user.displayName ?? '', user.phoneNumber ?? '',
            user.email ?? '', RolesConstants.user,  user.photoURL ?? '');
      }
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
