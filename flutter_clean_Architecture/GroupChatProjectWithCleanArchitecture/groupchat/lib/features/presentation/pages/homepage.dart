import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groupchat/const.dart';
import 'package:groupchat/features/data/remote_data_source/models/user_model.dart';
import 'package:groupchat/features/domine/entities/user_entity.dart';
import 'package:groupchat/features/presentation/cubit/auth/cubit/auth_cubit.dart';
import 'package:groupchat/features/presentation/cubit/user/cubit/user_cubit.dart';
import 'package:groupchat/features/presentation/pages/group_page.dart';
import 'package:groupchat/features/presentation/pages/profile_page.dart';
import 'package:groupchat/features/presentation/pages/users_page.dart';
import 'package:groupchat/features/presentation/widgets/text_container_widget.dart';
import 'package:groupchat/features/presentation/widgets/theme/style.dart';

import '../widgets/custom_toolbar_widget.dart';

class HomePage extends StatefulWidget {
  final String uid;
  const HomePage({super.key, required this.uid});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _searchController = TextEditingController();
  PageController _pageController = PageController(initialPage: 0);
  bool isSearch = false;
  int _toolbarPageIndex = 0;
  List<String> _popupMenuList = ['Logout'];
  List<Widget> get pages => [
        GroupPage(),
        UsersPage(
          uid: widget.uid,
          query: _searchController.text,
        ),
        ProfilePage(
          uid: widget.uid,
        )
      ];
  @override
  void dispose() {
    // TODO: implement dispose
    _searchController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<UserCubit>(context).getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: isSearch == true ? Colors.transparent : primaryColor,
          title: isSearch == true
              ? _emptyContainer()
              : Text('${AppConst.appName}'),
          flexibleSpace:
              isSearch == true ? _buildSearchWidget() : _emptyContainer(),
          actions: isSearch == true
              ? []
              : [
                  InkWell(
                      onTap: () {
                        setState(() {
                          isSearch = !isSearch;
                        });
                      },
                      child: Icon(Icons.search)),
                  PopupMenuButton(
                      onSelected: (value) {
                        if (value == 'Logout') {
                          BlocProvider.of<AuthCubit>(context).loggedOut();
                        }
                      },
                      itemBuilder: (_) => _popupMenuList.map((menuItem) {
                            return PopupMenuItem(
                              child: Text(menuItem),
                              value: menuItem,
                            );
                          }).toList()),
                ],
        ),
        body: Column(
          children: [
            isSearch == true
                ? _emptyContainer()
                : CustomTabBar(
                    pageindex: _toolbarPageIndex,
                    tabClickListener: (int index) {
                      print('Current $index');
                      setState(() {
                        _toolbarPageIndex = index;
                      });
                      // _pageController.jumpToPage(index);
                    },
                  ),
            Expanded(
              child:
                  //  _switchPage(currentUser: currentUser, users: users)
                  PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _toolbarPageIndex = index;
                  });
                },
                itemCount: pages.length,
                itemBuilder: (context, index) {
                  return pages[index];
                  // _switchPage(
                  //     currentUser: currentUser, users: users);
                },
              ),
            )
          ],
        )
        //  BlocBuilder<UserCubit, UserState>(
        //   builder: (context, userState) {
        //     if (userState is UserLoaded) {
        //       final currentUser = userState.users.firstWhere(
        //         (element) => element.uid == widget.uid,
        //         orElse: () => UserModel(),
        //       );
        //       final users = userState.users
        //           .where((element) => element.uid != widget.uid)
        //           .toList();
        //       return Column(
        //         children: [
        //           isSearch == true
        //               ? _emptyContainer()
        //               : CustomTabBar(
        //                   pageindex: _toolbarPageIndex,
        //                   tabClickListener: (int index) {
        //                     print('Current $index');
        //                     setState(() {
        //                       _toolbarPageIndex = index;
        //                     });
        //                     // _pageController.jumpToPage(index);
        //                   },
        //                 ),
        //           Expanded(
        //               child: _switchPage(currentUser: currentUser, users: users)
        //               // PageView.builder(
        //               //   controller: _pageController,
        //               //   onPageChanged: (index) {
        //               //     setState(() {
        //               //       _toolbarPageIndex = index;
        //               //     });
        //               //   },
        //               //   itemCount: users.length,
        //               //   itemBuilder: (context, index) {
        //               //     return _switchPage(
        //               //         currentUser: currentUser, users: users);
        //               //   },
        //               // ),
        //               )
        //         ],
        //       );
        //     }

        //     return Center(
        //       child: CircularProgressIndicator(),
        //     );
        //   },
        // ),
        );
  }

  // Widget _switchPage(
  //     {required List<UserEntity> users, required UserEntity currentUser}) {
  //   switch (_toolbarPageIndex) {
  //     case 0:
  //       return GroupPage();
  //     case 1:
  //       return UsersPage(
  //         users: users,
  //       );
  //     case 2:
  //       return ProfilePage(
  //         currentUser: currentUser,
  //       );
  //     default:
  //       return Container();
  //   }
  // }

  Widget _emptyContainer() {
    return Container(
      height: 0,
      width: 0,
    );
  }

  Widget _buildSearchWidget() {
    return SafeArea(
      child: Container(
        // margin: EdgeInsets.only(top: 25),
        height: 40,
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 2,
              spreadRadius: 1,
              offset: Offset(0, 0.50))
        ]),
        child: TextFieldContainer(
          controller: _searchController,
          hintText: 'Search..',
          isObscureText: false,
          keyboardType: TextInputType.text,
          prefixIcon: Icons.arrow_back,
          borderRadius: 0.0,
          color: Colors.white,
          iconClickEvent: () {
            setState(() {
              isSearch = !isSearch;
            });
          },
        ),
      ),
    );
  }
}
