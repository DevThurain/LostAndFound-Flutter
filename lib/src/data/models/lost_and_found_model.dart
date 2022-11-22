import 'package:dartz/dartz.dart';
import 'package:lost_and_found/src/data/vos/app_error.dart';
import 'package:lost_and_found/src/data/vos/item_vo.dart';
import 'package:lost_and_found/src/data/vos/user_vo.dart';

abstract class LostAndFoundModel {
  // auth
  Future<Either<AppError, UserVO>> registerUser(UserVO user);

  Future<Either<AppError, UserVO>> loginUser(UserVO user);

  Future<Either<AppError, String>> logoutUser();

  // item
  Future<Either<AppError, ItemVO>> uploadItem(ItemVO item);
}
