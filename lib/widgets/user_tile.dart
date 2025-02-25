import 'package:flutter/material.dart';
import '../models/user_model.dart';

class UserTile extends StatelessWidget {
  final UserModel user;
  final VoidCallback onTap;
  UserTile({required this.user, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(backgroundImage: NetworkImage(user.avatar)),
      title: Text("${user.firstName} ${user.lastName}"), 
      onTap: onTap,
    );
  }
}
