import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitial());

  @override
  Stream<SignupState> mapEventToState(SignupEvent event,) async* {
    if (event is SignupWithRequiredEvent) {
      yield SignupLoadingState();
      final result = await _signupWithRequiredEvent(event.email, event.pass);
      if (result == true) {
        yield SignupSuccessState();
      } else {
        yield SignupFailedState();
      }
    } else if (event is SignupWithRequiredEvent) {

    }
  }

  Future<bool> _signupWithRequiredEvent(String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return true;
    } catch(e){
      print(e);
      return false;
    }
  }
}
