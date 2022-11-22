part of 'register_bloc.dart';

@immutable
class RegisterState {
  UserVO? user;
  bool isLoading;
  bool isSuccess;
  AppError? appError;

  RegisterState({this.user, this.isLoading = false, this.isSuccess = false,this.appError});
}
