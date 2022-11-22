import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:lost_and_found/src/data/models/lost_and_found_model.dart';
import 'package:lost_and_found/src/data/vos/item_vo.dart';
import 'package:lost_and_found/src/data/vos/user_vo.dart';
import 'package:lost_and_found/src/data/vos/app_error.dart';
import 'package:lost_and_found/src/persistence/daos/user_dao.dart';

class LostAndFoundModelImpl extends LostAndFoundModel {
  // static final LostAndFoundModelImpl _instance = LostAndFoundModelImpl._internal();

  // factory LostAndFoundModelImpl._internal() {
  //   return _instance;
  // }

  // static LostAndFoundModelImpl get instance {
  //   return _instance;
  // }

  @override
  Future<Either<AppError, UserVO>> registerUser(UserVO user) async {
    try {
      // add to firebase auth
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );

      user.uuid = credential.user?.uid ?? "";
      user.token = credential.credential?.accessToken ?? "";

      // add to firestore
      final storeUser = <String, String>{
        "name": user.fullName,
        "email": user.email,
        "password": user.password,
        "phone": user.phone,
        "profileUrl": user.profileUrl,
        "token": user.token
      };

      var doc = FirebaseFirestore.instance.collection("users").doc(user.uuid);
      doc.set(storeUser);

      // add to db
      UserDao().addUser(user);

      return Right(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return Left(AppError(errorMessage: "The password provided is too weak."));
      } else if (e.code == 'email-already-in-use') {
        return Left(AppError(errorMessage: "The account already exists for that email."));
      }
    } catch (e) {
      return Left(AppError(errorMessage: e.toString()));
    }
    return Left(AppError(errorMessage: "Unknown Error"));
  }

  @override
  Future<Either<AppError, UserVO>> loginUser(UserVO user) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: user.email, password: user.password);

      user.uuid = credential.user?.uid ?? "";
      user.token = credential.credential?.accessToken ?? "";

      // FirebaseFirestore.instance.collection("users").doc(user.uuid).get().then((value) {
      //   var dataMap = value.data();
      //   if (dataMap != null) {
      //     var newUser = UserVO(
      //       dataMap["name"],
      //       dataMap["email"],
      //       dataMap["password"],
      //       dataMap["phone"],
      //       user.token,
      //       dataMap["profileUrl"],
      //       user.uuid,
      //     );
      //     UserDao().addUser(newUser);
      //     return Right(user);
      //   }
      // });

      var value = await FirebaseFirestore.instance.collection("users").doc(user.uuid).get();
      var dataMap = value.data();
      if (dataMap != null) {
        var newUser = UserVO(
          dataMap["name"],
          dataMap["email"],
          dataMap["password"],
          dataMap["phone"],
          user.token,
          dataMap["profileUrl"],
          user.uuid,
        );
        UserDao().addUser(newUser);
        return Right(user);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return Left(AppError(errorMessage: 'No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        return Left(AppError(errorMessage: "Wrong password provided for that user."));
      } else {
        return Left(AppError(errorMessage: e.toString()));
      }
    }
    return Left(AppError(errorMessage: "Unknown Error"));
  }

  @override
  Future<Either<AppError, String>> logoutUser() async {
    UserDao().deleteAllUser();

    await FirebaseAuth.instance.signOut();
    return Right("success");
  }

  @override
  Future<Either<AppError, ItemVO>> uploadItem(ItemVO item) async {
    item.timestamp = DateTime.now().microsecondsSinceEpoch.toString();
    item.uuid = UserDao().getUserList().first.uuid;
    item.userName = UserDao().getUserList().first.fullName;
    item.userProfile = UserDao().getUserList().first.profileUrl;
    
    // Create a storage reference from our app
    final storageRef = FirebaseStorage.instance.ref();

    // Create a reference to 'images/mountains.jpg'
    final itemRef = storageRef.child("items/${item.uuid}_${item.timestamp}.jpg");

    File file = File(item.photoPath);

    try {
      await itemRef.putFile(file);
      item.photoPath = await itemRef.getDownloadURL();
      print("photo --> + ${item.photoPath}");

      final storeItem = <String, dynamic>{
        "timestamp": item.timestamp,
        "name": item.name,
        "description": item.description,
        "contactInfo": item.contactInfo,
        "photoPath": item.photoPath,
        "address": item.address,
        "lat": item.lat,
        "lon": item.lon,
        "uuid": item.uuid,
        "userName": item.userName,
        "userProfile": item.userProfile
      };

      var doc = FirebaseFirestore.instance.collection("items").doc(item.timestamp);
      doc.set(storeItem);

      return Right(item);
    } on FirebaseException catch (e) {
      return Left(AppError(errorMessage: e.message ?? "unkown firebase error"));
    }
  }

  // await Future.delayed(Duration(seconds: 2));

  // // return Left(AppError(errorMessage: "Mock Error"));
  // return Right(UserVO("", "", "", "", "", "", ""));
}
