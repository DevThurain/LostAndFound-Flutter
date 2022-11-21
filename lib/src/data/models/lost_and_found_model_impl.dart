import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lost_and_found/src/data/models/lost_and_found_model.dart';
import 'package:lost_and_found/src/data/vos/user_vo.dart';
import 'package:lost_and_found/src/data/vos/app_error.dart';
import 'package:lost_and_found/src/persistence/daos/user_dao.dart';

class LostAndFoundModelImpl extends LostAndFoundModel {
  @override
  Future<Either<AppError, UserVO>> registerUser(UserVO user) async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );

      user.uuid = credential.user?.uid ?? "";
      user.token = credential.credential?.accessToken ?? "";

      final storeUser = <String, String>{
        "name": user.fullName,
        "email": user.email,
        "password": user.password,
        "phone": user.phone,
        "profileUrl": user.profileUrl
      };

      var doc = FirebaseFirestore.instance.collection("users").doc(user.uuid);
      doc.set(storeUser);
      UserDao().addUser(user);

      return Right(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return Left(AppError("The password provided is too weak."));
      } else if (e.code == 'email-already-in-use') {
        return Left(AppError("The account already exists for that email."));
      }
    } catch (e) {
      return Left(AppError(e.toString()));
    }
    return Left(AppError("Unknown Error"));
  }
}
