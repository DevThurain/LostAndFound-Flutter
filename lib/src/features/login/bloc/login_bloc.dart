import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:lost_and_found/src/data/models/lost_and_found_model_impl.dart';
import 'package:lost_and_found/src/data/vos/app_error.dart';
import 'package:lost_and_found/src/data/vos/user_vo.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LostAndFoundModelImpl _lostAndFoundModelImpl = LostAndFoundModelImpl();

  LoginBloc() : super(LoginState()) {
    on<LoginEvent>((event, emit) async {
      if (event is EventOnLogin) {
        emit(LoginState(isLoading: true));

        var loginEvent = event;
        Either<AppError, UserVO> registerResponse =
            await _lostAndFoundModelImpl.loginUser(loginEvent.email, loginEvent.password);

        registerResponse.fold((left) {
          emit(LoginState(appError: left));
        }, (right) {
          emit(LoginState(user: right, isSuccess: true));
        });
      }
    });
  }
}
