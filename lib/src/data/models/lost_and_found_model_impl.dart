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
  static final LostAndFoundModelImpl _singleton = LostAndFoundModelImpl._internal();

  factory LostAndFoundModelImpl() {
    return _singleton;
  }

  LostAndFoundModelImpl._internal();

  @override
  Future<Either<AppError, UserVO>> registerUser(String fullName, String email, String phone, String password) async {
    try {
      // add to firebase auth
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String uuid = credential.user?.uid ?? "";
      String token = credential.credential?.accessToken ?? "";

      // add to firestore
      final storeUser = UserVO(
          fullName: fullName, email: email, phone: phone, uuid: uuid, token: token, profileUrl: '');

      var doc = FirebaseFirestore.instance.collection("users").doc(uuid);
      doc.set(storeUser.toFirestore());

      // add to db
      UserDao().addUser(storeUser);

      return Right(storeUser);
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
  Future<Either<AppError, UserVO>> loginUser(String email, String password) async {
    try {
      final credential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);

      String uuid = credential.user?.uid ?? "";
      String token = credential.credential?.accessToken ?? "";

      var snapShot = await FirebaseFirestore.instance.collection("users").doc(uuid).get();

      UserVO storeUser = UserVO.fromFireStore(snapShot);

      UserDao().addUser(storeUser);
      return Right(storeUser);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return Left(AppError(errorMessage: 'No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        return Left(AppError(errorMessage: "Wrong password provided for that user."));
      } else {
        return Left(AppError(errorMessage: e.toString()));
      }
    } catch (e) {
      return Left(AppError(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<AppError, String>> logoutUser() async {
    try {
      await FirebaseAuth.instance.signOut();
      UserDao().deleteUser(FirebaseAuth.instance.currentUser!.uid);
    } catch (e) {
      return Left(AppError(errorMessage: e.toString()));
    }

    return Right("success");
  }

  @override
  Future<Either<AppError, ItemVO>> uploadItem(String name, String description, String contactInfo,double lat, double lon, String address, String photoPath, List<String> tags) async {
    int timestamp = DateTime.now().microsecondsSinceEpoch;
    String uuid = FirebaseAuth.instance.currentUser!.uid;

    // Create a storage reference from our app
    final storageRef = FirebaseStorage.instance.ref();

    // Create a reference to 'images/mountains.jpg'
    final itemRef = storageRef.child("items/${uuid}_${timestamp}.jpg");

    File file = File(photoPath);

    try {
      await itemRef.putFile(file);
      String downloadUrl = await itemRef.getDownloadURL();

      ItemVO storeItem = ItemVO(
        timestamp: timestamp,
        name: name,
        description: description,
        contactInfo: contactInfo,
        lat: lat,
        lon: lon,
        photoPath: downloadUrl,
        address: address,
        tags: tags,
        user: UserDao().getUser(uuid)!,
      );

      var doc = FirebaseFirestore.instance.collection("items").doc(storeItem.timestamp.toString());
      doc.set(storeItem.toFireStore());

      return Right(storeItem);
    } on FirebaseException catch (e) {
      return Left(AppError(errorMessage: e.message ?? "unkown firebase error"));
    }
  }

  @override
  Future<Either<AppError, Map<String, dynamic>>> fetchFirstItems(int limit) async {
    try {
      var value = await FirebaseFirestore.instance
          .collection("items")
          .orderBy("timestamp", descending: true)
          .limit(limit)
          .get();

      var docs = value.docs;
      print('-----------------> fectch first');

      List<ItemVO> newItems = [];

      docs.forEach((document) {
        newItems.add(ItemVO.fromFireStore(document));
      });

      var map = <String, dynamic>{"items": newItems, "documents": value.docs};

      return Right(map);
    } on FirebaseException catch (e) {
      return Left(AppError(errorMessage: e.message ?? "unknown firestore error"));
    }
  }

  @override
  Future<Either<AppError, Map<String, dynamic>>> fetchNextItems(List<DocumentSnapshot> documentList, int limit) async {
    try {
      if (documentList.isNotEmpty) {
        var value = await FirebaseFirestore.instance
            .collection("items")
            .orderBy("timestamp", descending: true)
            .startAfterDocument(documentList[documentList.length - 1])
            .limit(limit)
            .get();

        var docs = value.docs;
        print('-----------------> fectch next');

        List<ItemVO> newItems = [];
        docs.forEach((document) {
          newItems.add(ItemVO.fromFireStore(document));
        });

        var map = <String, dynamic>{"items": newItems, "documents": value.docs};

        return Right(map);
      } else {
        var map = <String, dynamic>{
          "items": List<ItemVO>.empty(),
          "documents": List<DocumentSnapshot>.empty()
        };
        return Right(map);
      }
    } on FirebaseException catch (e) {
      return Left(AppError(errorMessage: e.message ?? "unknown firestore error"));
    }
  }
}
