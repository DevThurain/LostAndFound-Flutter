import 'package:hive_flutter/hive_flutter.dart';
import 'package:lost_and_found/src/data/vos/user_vo.dart';
import 'package:lost_and_found/src/persistence/hive_constants.dart';

class UserDao {
  // bool dataAlreadyExist(int videoId){
  //   return openVideoDataBox().containsKey(videoId);
  // }

  void addUser(UserVO userVO) {
    openUserBox().put(userVO.uuid, userVO);
  }

  void deleteUser(String uuid) {
    openUserBox().delete(uuid);
  }

  void deleteAllUser() {
    var userList = getUserList();
    userList.forEach((user) {
      openUserBox().delete(user.uuid);
    });
  }

  List<UserVO> getUserList() {
    return openUserBox().values.toList();
  }

  Box<UserVO> openUserBox() {
    return Hive.box<UserVO>(HiveConstants.BOX_NAME_USER_DATA);
  }
}
