part of 'login_bloc.dart';

@immutable
class LoginState {
  UserVO? user;
  bool isLoading;
  bool isSuccess;
  AppError? appError;

  LoginState({this.user, this.isLoading = false, this.isSuccess = false,this.appError});
}
