import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:msf/services/database.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitial());

  @override
  Stream<SignupState> mapEventToState(SignupEvent event,) async* {
    if (event is SignupWithRequiredEvent) {
      yield SignupLoadingState();
      final result = await _signupWithRequiredEvent(event.name, event.email, event.phoneNo, event.pass);
      if (result == true) {
        yield SignupSuccessState();
      } else {
        yield SignupFailedState();
      }
    } else if (event is SignupWithRequiredEvent) {

    }
  }

  Future<bool> _signupWithRequiredEvent(String name, String email, String phoneNo,String password) async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email : email,
        password : password,
      );
      final db = DatabaseService(uid: credential.user!.uid);
      db.updateUserData(name, email, phoneNo, '');
      return true;
    } catch(e){
      print(e);
      return false;
    }
  }
}
