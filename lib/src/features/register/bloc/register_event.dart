part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent {}

class EventOnRegister extends RegisterEvent {
  final String fullName;
  final String email;
  final String phone;
  final String password;
  EventOnRegister({required this.fullName, required this.email, required this.phone, required this .password});
}
