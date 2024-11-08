import 'package:flutter/material.dart';
import 'package:groupchat/features/domine/entities/user_entity.dart';
import 'package:groupchat/features/presentation/widgets/single_item_user_widget.dart';

class UsersPage extends StatelessWidget {
  final List<UserEntity> users;

  const UsersPage({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return SingleItemUserWidget(
                    onTap: () {},
                    profileUser: users[index],
                  );
                }),
          )
        ],
      ),
    );
  }
}
