import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:lost_and_found/src/data/vos/app_error.dart';
import 'package:lost_and_found/src/data/vos/item_vo.dart';
import 'package:lost_and_found/src/data/vos/user_vo.dart';

abstract class LostAndFoundModel {
  // auth
  Future<Either<AppError, UserVO>> registerUser(String fullName, String email, String phone, String password);

  Future<Either<AppError, UserVO>> loginUser(String email, String password);

  Future<Either<AppError, String>> logoutUser();

  // item
  Future<Either<AppError, ItemVO>> uploadItem(String name, String description, String contactInfo, double lat, double lon, String address, String photoPath, List<String> tags);

  Future<Either<AppError, Map<String,dynamic>>> fetchFirstItems(int limit);
  Future<Either<AppError, Map<String,dynamic>>> fetchNextItems(List<DocumentSnapshot> documentList,int limit);

}
