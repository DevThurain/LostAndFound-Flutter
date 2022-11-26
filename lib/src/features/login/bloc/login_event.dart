part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class EventOnLogin extends LoginEvent {
  final String email;
  final String password;
  EventOnLogin({required this.email, required this.password});
}
