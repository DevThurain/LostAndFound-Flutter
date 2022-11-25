import 'package:cloud_firestore/cloud_firestore.dart';
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

  Future<Either<AppError, Map<String,dynamic>>> fetchFirstItems(int limit);
  Future<Either<AppError, Map<String,dynamic>>> fetchNextItems(List<DocumentSnapshot> documentList,int limit);

}
