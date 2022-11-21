import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lost_and_found/firebase_options.dart';
import 'package:lost_and_found/src/data/vos/user_vo.dart';
import 'package:lost_and_found/src/persistence/hive_constants.dart';

import 'src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await _initializeHive();
  runApp(MyApp());
}

_initializeHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());

  await Hive.openBox<UserVO>(HiveConstants.BOX_NAME_USER_DATA);
}
