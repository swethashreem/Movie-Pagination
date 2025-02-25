import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  final String firstName;
  @HiveField(1)
  final String lastName;
  @HiveField(2)
  final String avatar;
  @HiveField(3)
  final String job;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.avatar,
    required this.job,
  });

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "avatar": avatar,
        "job": job,
      };

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      firstName: json["first_name"] ?? '',
      lastName: json["last_name"] ?? '',
      avatar: json["avatar"] ?? '',
      job: json["job"] ?? '',
    );
  }
}
