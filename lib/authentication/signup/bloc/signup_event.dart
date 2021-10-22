part of 'signup_bloc.dart';

@immutable
abstract class SignupEvent {}
class SignupWithRequiredEvent extends SignupEvent {
  final String name;
  final String email;
  final String phoneNo;
  final String pass;


  SignupWithRequiredEvent(this.name, this.email, this.phoneNo, this.pass);
}

class LoginWithGoogleEvent extends SignupEvent {}
