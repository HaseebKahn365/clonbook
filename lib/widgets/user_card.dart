import 'package:flutter/material.dart';

import '../models/user_model.dart';
import 'widgets.dart';

class UserCard extends StatelessWidget {
  final User user;
  const UserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ProfileAvatar(imageUrl: user.imageUrl),
        const SizedBox(
          width: 6,
        ),
        Text(
          user.name,
          style: const TextStyle(fontSize: 16),
        )
      ],
    );
  }
}
