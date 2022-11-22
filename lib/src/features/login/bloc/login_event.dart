part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}


class EventOnLogin extends LoginEvent {
  final UserVO userVO;
  EventOnLogin({required this.userVO});
}