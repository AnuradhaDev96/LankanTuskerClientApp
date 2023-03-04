import 'package:hive/hive.dart';

import '../enums/user_types.dart';

part 'authenticated_user.g.dart';


@HiveType(typeId: 0)
class AuthenticatedUser {
  @HiveField(0)
  String displayName;

  @HiveField(1)
  String email;

  @HiveField(2)
  int token;

  @HiveField(3)
  UserTypes userType;

  @HiveField(4)
  int userId;

  AuthenticatedUser({
    required this.displayName,
    required this.email,
    required this.token,
    required this.userType,
    required this.userId
  });

  Map<String, dynamic> toMap(){
    return {
      'displayName': displayName,
      'email': email,
      'token': token,
      'userType': userType,
    };
  }

  AuthenticatedUser.fromMap(Map<String, dynamic> map):
        displayName = map["displayName"],
        email = map["email"],
        token = map["token"],
        userId = map["id"],
        userType = map["userType"];

}