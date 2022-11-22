import 'package:dartz/dartz.dart';
import 'package:lost_and_found/src/data/vos/app_error.dart';
import 'package:lost_and_found/src/data/vos/user_vo.dart';

abstract class LostAndFoundModel {
  Future<Either<AppError, UserVO>> registerUser(UserVO user);

  Future<Either<AppError, UserVO>> loginUser(UserVO user);

    Future<Either<AppError, String>> logoutUser();

}
