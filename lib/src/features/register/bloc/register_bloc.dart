import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:lost_and_found/src/data/models/lost_and_found_model.dart';
import 'package:lost_and_found/src/data/models/lost_and_found_model_impl.dart';
import 'package:lost_and_found/src/data/vos/app_error.dart';
import 'package:lost_and_found/src/data/vos/user_vo.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final LostAndFoundModelImpl _lostAndFoundModelImpl = LostAndFoundModelImpl();

  RegisterBloc() : super(RegisterState()) {
    on<RegisterEvent>((event, emit) async {
      if (event is EventOnRegister) {
        emit(RegisterState(isLoading: true));

        var registerEvent = event;
        Either<AppError, UserVO> registerResponse =
            await _lostAndFoundModelImpl.registerUser(registerEvent.userVO);

        registerResponse.fold((left) {
          emit(RegisterState(appError: left));
        }, (right) {
          emit(RegisterState(user: right,isSuccess: true));
        });
      }
    });
  }
}
