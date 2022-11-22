part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent {}

class EventOnRegister extends RegisterEvent {
  final UserVO userVO;
  EventOnRegister({required this.userVO});
}
