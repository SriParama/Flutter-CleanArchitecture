import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groupchat/features/domine/entities/user_entity.dart';
import 'package:groupchat/features/presentation/cubit/user/cubit/user_cubit.dart';
import 'package:groupchat/features/presentation/widgets/container_button_widget.dart';
import 'package:groupchat/features/presentation/widgets/text_container_widget.dart';
import 'package:groupchat/features/presentation/widgets/theme/style.dart';

class ProfilePage extends StatefulWidget {
  // final String uid;
  final UserEntity currentUser;
  const ProfilePage({super.key, required this.currentUser});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _statusController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController.value = TextEditingValue(text: widget.currentUser.name!);
    _statusController.value =
        TextEditingValue(text: widget.currentUser.status!);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _nameController.dispose();
    _statusController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            height: 62,
            width: 62,
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(62)),
            child: Text(""),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Remove profile photo',
            style: TextStyle(
                color: greenColor, fontSize: 12, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 10,
          ),
          TextFieldContainer(
            controller: _nameController,
            hintText: 'name',
            prefixIcon: Icons.person,
          ),
          SizedBox(
            height: 10,
          ),
          TextFieldContainer(
            hintText: 'email',
            prefixIcon: Icons.email,
          ),
          SizedBox(
            height: 10,
          ),
          TextFieldContainer(
            controller: _statusController,
            hintText: 'status',
            prefixIcon: Icons.info,
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            thickness: 1.50,
          ),
          SizedBox(
            height: 10,
          ),
          ContainerButtonWidget(
              title: 'Update Profile', onTap: _updateUserProfile
              //  () {
              //   _updateUserProfile();
              //   print('Update Profile');
              // }

              )
        ],
      ),
    );
  }

  void _updateUserProfile() {
    // print('hi');

    BlocProvider.of<UserCubit>(context).updateUser(
        user: UserEntity(
            uid: widget.currentUser.uid,
            name: _nameController.text,
            status: _statusController.text));
  }
}
