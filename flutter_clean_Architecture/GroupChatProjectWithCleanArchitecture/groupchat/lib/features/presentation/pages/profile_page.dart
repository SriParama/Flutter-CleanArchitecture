import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groupchat/features/domine/entities/user_entity.dart';
import 'package:groupchat/features/presentation/cubit/user/cubit/user_cubit.dart';
import 'package:groupchat/features/presentation/widgets/container_button_widget.dart';
import 'package:groupchat/features/presentation/widgets/text_container_widget.dart';
import 'package:groupchat/features/presentation/widgets/theme/style.dart';

import '../../data/remote_data_source/models/user_model.dart';

// class ProfilePage extends StatefulWidget {
//   final String uid;
//   // final UserEntity currentUser;
//   const ProfilePage({super.key, required this.uid});

//   @override
//   State<ProfilePage> createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   TextEditingController _nameController = TextEditingController();
//   TextEditingController _statusController = TextEditingController();

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _nameController.value = TextEditingValue(text: widget.currentUser.name!);
//     _statusController.value =
//         TextEditingValue(text: widget.currentUser.status!);
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     _nameController.dispose();
//     _statusController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(10),
//       child: Column(
//         children: [
//           Container(
//             height: 62,
//             width: 62,
//             decoration: BoxDecoration(
//                 color: Colors.grey, borderRadius: BorderRadius.circular(62)),
//             child: Text(""),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Text(
//             'Remove profile photo',
//             style: TextStyle(
//                 color: greenColor, fontSize: 12, fontWeight: FontWeight.w500),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           TextFieldContainer(
//             controller: _nameController,
//             hintText: 'name',
//             prefixIcon: Icons.person,
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           TextFieldContainer(
//             hintText: 'email',
//             prefixIcon: Icons.email,
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           TextFieldContainer(
//             controller: _statusController,
//             hintText: 'status',
//             prefixIcon: Icons.info,
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Divider(
//             thickness: 1.50,
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           ContainerButtonWidget(
//               title: 'Update Profile', onTap: _updateUserProfile
//               //  () {
//               //   _updateUserProfile();
//               //   print('Update Profile');
//               // }

//               )
//         ],
//       ),
//     );
//   }

//   void _updateUserProfile() {
//     // print('hi');

//     BlocProvider.of<UserCubit>(context).updateUser(
//         user: UserEntity(
//             uid: widget.currentUser.uid,
//             name: _nameController.text,
//             status: _statusController.text));
//   }
// }

class ProfilePage extends StatefulWidget {
  final String uid;

  const ProfilePage({Key? key, required this.uid}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _statusController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _numController = TextEditingController();

  // File? _image;
  String? _profileUrl;
  String? _username;
  String? _phoneNumber;
  // final picker = ImagePicker();

  void dispose() {
    _nameController!.dispose();
    _statusController!.dispose();
    _emailController!.dispose();
    _numController!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _nameController = TextEditingController(text: "");
    _statusController = TextEditingController(text: "");
    _emailController = TextEditingController(text: "");
    _numController = TextEditingController(text: "");
    super.initState();
  }

  // Future getImage() async {
  //   try {
  //     final pickedFile = await picker.getImage(source: ImageSource.gallery);

  //     setState(() {
  //       if (pickedFile != null) {
  //         _image = File(pickedFile.path);
  //         StorageProviderRemoteDataSource.uploadFile(file: _image!)
  //             .then((value) {
  //           print("profileUrl");
  //           setState(() {
  //             _profileUrl = value;
  //           });
  //         });
  //       } else {
  //         print('No image selected.');
  //       }
  //     });
  //   } catch (e) {
  //     toast("error $e");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, userState) {
        if (userState is UserLoaded) {
          return _profileWidget(userState.users);
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _profileWidget(List<UserEntity> users) {
    final user = users.firstWhere((user) => user.uid == widget.uid,
        orElse: () => UserModel());
    _nameController.value = TextEditingValue(text: "${user.name}");
    _emailController.value = TextEditingValue(text: "${user.email}");
    _statusController.value = TextEditingValue(text: "${user.status}");

    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                // getImage();
              },
              child: Container(
                height: 62,
                width: 62,
                decoration: BoxDecoration(
                  color: color747480,
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    child: Icon(Icons.person)
                    // profileWidget(imageUrl: user.profileUrl, image: _image),
                    ),
              ),
            ),
            SizedBox(
              height: 14,
            ),
            Text(
              'Remove profile photo',
              style: TextStyle(
                  color: greenColor, fontSize: 16, fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 28,
            ),
            Container(
              margin: EdgeInsets.only(left: 22, right: 22),
              height: 47,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: color747480.withOpacity(.2),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: TextField(
                controller: _nameController,
                onChanged: (textData) {
                  _username = textData;
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.grey,
                  ),
                  hintText: 'username',
                  hintStyle:
                      TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.only(left: 22, right: 22),
              height: 47,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: color747480.withOpacity(.2),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: AbsorbPointer(
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.mail,
                      color: Colors.grey,
                    ),
                    hintText: 'email',
                    hintStyle:
                        TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.only(left: 22, right: 22),
              height: 47,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: color747480.withOpacity(.2),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: TextField(
                controller: _statusController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.star_outline_sharp,
                    color: Colors.grey,
                  ),
                  hintText: 'status',
                  hintStyle:
                      TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                ),
              ),
            ),
            SizedBox(
              height: 14,
            ),
            Divider(
              thickness: 1,
              endIndent: 15,
              indent: 15,
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                _updateProfile();
              },
              child: Container(
                  margin: EdgeInsets.only(left: 22, right: 22),
                  alignment: Alignment.center,
                  height: 44,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: greenColor,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Text(
                    'Update',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  )),
            )
          ],
        ),
      ),
    );
  }

  void _updateProfile() {
    BlocProvider.of<UserCubit>(context).updateUser(
      user: UserEntity(
        uid: widget.uid,
        name: _nameController!.text,
        status: _statusController!.text,
        // profileUrl: _profileUrl!,
      ),
    );
    // toast("Profile Updated");
  }
}