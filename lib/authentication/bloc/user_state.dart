part of 'user_bloc.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserLoadingState extends UserState {}

class UserAuthenticatedState extends UserState {}

class UserUnAuthenticatedState extends UserState {}
