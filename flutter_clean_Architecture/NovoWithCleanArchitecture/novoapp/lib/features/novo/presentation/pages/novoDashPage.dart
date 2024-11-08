import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novoapp/core/common/globleVariables.dart';
import 'package:novoapp/core/common/show_snackbar.dart';
import 'package:novoapp/core/cubits/internet_cubit/internet_cubit.dart';
import 'package:novoapp/core/theme/app_colors.dart';
import 'package:novoapp/features/auth/presentation/blocs/auth_cookie_cubit/auth_cookie_cubit.dart';
import 'package:novoapp/features/auth/presentation/pages/LogInPages/loginWithPwdPage.dart';
import 'package:novoapp/features/novo/data/novo_data_source/models/dashboard_model.dart';
import 'package:novoapp/features/novo/presentation/bloc/Fetch_data_Cubit/fetch_data_cubit.dart';
import 'package:novoapp/features/novo/presentation/pages/ipopage.dart';

class NovoDashBoardPage extends StatefulWidget {
  // final String cookie;
  static const String routeName = '/dashboard';
  const NovoDashBoardPage({super.key});

  @override
  State<NovoDashBoardPage> createState() => _NovoDashBoardPageState();
}

class _NovoDashBoardPageState extends State<NovoDashBoardPage> {
  late Timer timer;
  DashboardModel? dashboardModel;
  List<SegmentArr> dashboardData = [];
  String clientId = 'gg';
  @override
  void initState() {
    // BlocProvider.of<AuthCookieCubit>(context).loggedIn();
    // context.read<AuthCookieCubit>().loggedIn();
    // FetchDataState state = context.read<FetchDataCubit>().state;
    // print(state);
    // if (state is FetchDataLoaded) {
    //   // print(state.props[0] is DashboardModel);
    //   DashboardModel dashboardModel = state.props[0] as DashboardModel;
    //   List<SegmentArr> dashboardData = dashboardModel.segmentArr!;
    //   String clientId = state.props[1] as String;
    //   print(dashboardData);
    //   print(clientId);
    //   //    List<SegmentArr> dashboardData = ;
    //   // String clientId = fetchState.clientId;
    // } else {
    //   dashboardModel;
    //   dashboardData = [];
    //   clientId = '';
    // }
    context.read<AuthCookieCubit>().loggedIn();
    // FetchDataState state = context.read<FetchDataCubit>().state;
    // if (state is FetchDataLoaded) {
    //   // print(state.props[0] is DashboardModel);
    //   DashboardModel dashboardModel = state.props[0] as DashboardModel;
    //   List<SegmentArr> dashboardData = dashboardModel.segmentArr!;
    //   String clientId = state.props[1] as String;
    //   print(dashboardData);
    //   print(clientId);
    //   //    List<SegmentArr> dashboardData = ;
    //   // String clientId = fetchState.clientId;
    // } else {}
    // print(context.read<FetchDataCubit>().state);
    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      print('main.........');
      context.read<AuthCookieCubit>().loggedIn();
      // BlocProvider.of<AuthCookieCubit>(context).loggedIn();

      // context.read<FetchDataCubit>().state;
    });

    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<AuthCookieCubit, AuthCookieState>(
      listener: (context, state) {
        if (state is AuthCookieInvalid) {
          print('))))))))))))0');
          context.read<AuthCookieCubit>().loggedIn();
          // Navigator.pushAndRemoveUntil(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => LoginPage(),
          //   ),
          //   (route) => false,
          // );
        }
        // TODO: implement listener
      },
      child: BlocBuilder<FetchDataCubit, FetchDataState>(
          builder: (context, fetchState) {
        if (fetchState is FetchDataLoaded) {
          List<SegmentArr> dashboardData = fetchState.dashboardData.segmentArr!;
          String clientId = fetchState.clientId;

          return _dashBoardWidget(dashboardData, clientId);
        } else {
          return Center(
            child: CircularProgressIndicator(
              color: appPrimeColor,
            ),
          );
        }
      }),
    )

        // _dashBoardWidget(dashboardData, clientId)

        // BlocSelector<AuthCookieCubit, AuthCookieState, bool>(
        //   selector: (state) {
        //     return state is AuthCookieValidated;
        //   },
        //   builder: (context, state) {
        //     if (state) {
        //       return BlocBuilder<FetchDataCubit, FetchDataState>(
        //         builder: (context, fetchState) {
        //           if (fetchState is FetchDataLoaded) {
        //             // List<SegmentArr> dashboardData =
        //             //     fetchState.dashboardData.segmentArr!;
        //             // String clientId = fetchState.clientId;

        //             return _dashBoardWidget(dashboardData, clientId);
        //           } else {
        //             return Center(
        //               child: CircularProgressIndicator(
        //                 color: appPrimeColor,
        //               ),
        //             );
        //           }
        //         },
        //       );
        //     } else {
        //       timer.cancel();
        //       return LoginPage();
        //     }
        //   },
        // ),
        );
  }

  _dashBoardWidget(List<SegmentArr> dashboardData, String clientId) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              systemNavigationBarDividerColor: Colors.transparent,
              statusBarIconBrightness:
                  // darkThemeMode ? Brightness.light :
                  Brightness.dark),
          elevation: 0,
          title: GestureDetector(
            onTap: () {
              // changeindex.value = 0;
            },
            child: Image.asset(
              // Provider.of<NavigationProvider>(context).themeMode ==
              //         ThemeMode.dark
              //     ? 'assets/novoLogoBlack.png'
              //     :
              'assets/images/Novo Transp.png',
              width: 100.0,
              height: 100.0,
            ),
          ),
          centerTitle: true,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                  icon: Icon(
                    CupertinoIcons.line_horizontal_3,
                    color: titleTextColorLight,
                    size: 25,
                  ), // Use the menu icon for the drawer
                  onPressed: () {
                    Scaffold.of(context).openDrawer(); // Open the drawer
                  },
                  color: titleTextColorLight);
            },
          ),
          actions: [
            Builder(
              builder: (context) {
                return IconButton(
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                  icon: Icon(Icons.notifications),
                  color: titleTextColorLight,
                );
              },
            )
          ],
        ),
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              DrawerHeader(
                  decoration: BoxDecoration(
                      color:
                          // Provider.of<NavigationProvider>(context).themeMode ==
                          //         ThemeMode.dark
                          //     ? titleTextColorLight
                          //     :

                          appPrimeColor),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                                color:
                                    //  Provider.of<NavigationProvider>(context)
                                    //             .themeMode ==
                                    //         ThemeMode.dark
                                    //     ? appPrimeColor
                                    //     :
                                    Color.fromRGBO(187, 222, 251, 1),
                                borderRadius: BorderRadius.circular(50.0)),
                            child: FittedBox(
                              child: Text(
                                'SRI',
                                style: TextStyle(
                                    color:
                                        // Provider.of<NavigationProvider>(context)
                                        //             .themeMode ==
                                        //         ThemeMode.dark
                                        //     ? Color.fromRGBO(187, 222, 251, 1)
                                        //     :
                                        appPrimeColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Kiro'),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              // Provider.of<NavigationProvider>(context,
                              //         listen: false)
                              //     .toggleTheme(context);
                            },
                            icon:
                                //  Provider.of<NavigationProvider>(context)
                                //             .themeMode ==
                                //         ThemeMode.dark
                                //     ? Icon(
                                //         CupertinoIcons.moon_stars_fill,
                                //         color: Colors.white,
                                //         size: 25.0,
                                //       )
                                //     :
                                Icon(
                              CupertinoIcons.brightness_solid,
                              color: Colors.white,
                              size: 25.0,
                            ),
                          )
                        ],
                      ),
                      Text(
                        clientId.toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: titleFontSize,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Kiro'),
                      ),
                    ],
                  )),
              ListTile(
                dense: true,
                leading: Image.asset(
                  "assets/images/layout.png",
                  width: 20.0,
                  color:
                      //  Provider.of<NavigationProvider>(context).themeMode ==
                      //         ThemeMode.dark
                      //     ? titleTextColorDark
                      //     :
                      titleTextColorLight,
                ),
                title: Text(
                  "NOVO",
                  style: TextStyle(
                      fontFamily: 'Kiro',
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.bold,
                      color:
                          //  changeindex.value == 0
                          //     ? Provider.of<NavigationProvider>(context)
                          //                 .themeMode ==
                          //             ThemeMode.dark
                          //         ? Colors.blue.shade400
                          //         : appPrimeColor
                          //     : Provider.of<NavigationProvider>(context)
                          //                 .themeMode ==
                          //             ThemeMode.dark
                          //         ? titleTextColorDark
                          //         :
                          titleTextColorLight),
                ),
                onTap: () {
                  // changeindex.value = 0;

                  Navigator.pop(context);
                },
              ),
              ...dashboardData.map(
                (e) => ListTile(
                  dense: true,
                  leading:
                      //  Provider.of<NavigationProvider>(context).themeMode ==
                      //         ThemeMode.dark
                      //     ? Image.network(
                      //         "${e.darkThemeImage}",
                      //         width: 20.0,
                      //       )
                      //     :
                      Image.network(
                    "${e.image}",
                    width: 20.0,
                  ),
                  title: Text(
                    '${e.name}',
                    style: TextStyle(
                        fontFamily: 'Kiro',
                        fontSize: titleFontSize,
                        fontWeight: FontWeight.bold,
                        color:
                            //  changeindex.value ==
                            //         novoDashBoardDataList.indexOf(e) + 1
                            //     ? Provider.of<NavigationProvider>(context)
                            //                 .themeMode ==
                            //             ThemeMode.dark
                            //         ? Colors.blue.shade400
                            //         : appPrimeColor
                            //     : Provider.of<NavigationProvider>(context)
                            //                 .themeMode ==
                            //             ThemeMode.dark
                            //         ? titleTextColorDark
                            //         :
                            titleTextColorLight),
                  ),
                  onTap: () {
                    // changeindex.value = novoDashBoardDataList.indexOf(e) + 1;
                    // print('hi');
                    Navigator.pop(context);
                  },
                ),
              ),
              ListTile(
                dense: true,
                leading: Icon(
                  CupertinoIcons.power,
                  size: 17,
                  color: titleTextColorLight,
                ),
                title: Text(
                  "Logout",
                  style: TextStyle(
                    fontFamily: 'Kiro',
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.bold,
                    color: titleTextColorLight,
                  ),
                ),
                onTap: () {
                  context.read<AuthCookieCubit>().loggedOut();
                  // Navigator.popUntil(
                  //   context,
                  //   (route) => false,
                  // );
                  // context.read<AuthCookieCubit>().loggedOut();
                  // showDialog(
                  //   context: context,
                  //   builder: (context) {
                  //     return AlertDialog(
                  //       content: Text(
                  //         'Do you want to Logout ?',
                  //         style: TextStyle(
                  //             fontSize: 13.0,
                  //             color: titleTextColorLight,
                  //             fontWeight: FontWeight.bold),
                  //       ),
                  //       actions: [
                  //         SizedBox(
                  //           height: 25.0,
                  //           child: ElevatedButton(
                  //               style: ButtonStyle(
                  //                   shape: MaterialStatePropertyAll(
                  //                       RoundedRectangleBorder(
                  //                           borderRadius:
                  //                               BorderRadius.circular(18.0))),
                  //                   backgroundColor: MaterialStatePropertyAll(
                  //                       // Provider.of<NavigationProvider>(context)
                  //                       //             .themeMode ==
                  //                       //         ThemeMode.dark
                  //                       //     ? Colors.white
                  //                       //     :
                  //                       appPrimeColor)),
                  //               onPressed: () {
                  //                 // Navigator.of(context).pop();
                  //                 // BlocProvider.of<AuthCookieCubit>(context)
                  //                 //     .loggedOut();
                  //                 context.read<AuthCookieCubit>().loggedOut();
                  //                 // loadingAlertBox(context, 'Logging Out...');
                  //                 // closeLogoutLoadingAlertBox();
                  //               },
                  //               child: Text(
                  //                 'Yes',
                  //                 style: TextStyle(
                  //                     fontFamily: 'inter',
                  //                     fontSize: 12.0,
                  //                     color:

                  //                         //  Provider.of<NavigationProvider>(
                  //                         //                 context)
                  //                         //             .themeMode ==
                  //                         //         ThemeMode.dark
                  //                         //     ? Colors.black
                  //                         //     :
                  //                         Colors.white),
                  //               )),
                  //         ),
                  //         SizedBox(
                  //           height: 25.0,
                  //           child: ElevatedButton(
                  //               style: ButtonStyle(
                  //                   shape: MaterialStatePropertyAll(
                  //                       RoundedRectangleBorder(
                  //                           borderRadius:
                  //                               BorderRadius.circular(18.0))),
                  //                   backgroundColor: MaterialStatePropertyAll(
                  //                       // Provider.of<NavigationProvider>(context).themeMode ==
                  //                       //         ThemeMode.dark
                  //                       //     ? Colors.white
                  //                       //     :
                  //                       appPrimeColor)),
                  //               onPressed: () => Navigator.of(context).pop(),
                  //               child: Text('No',
                  //                   style: TextStyle(
                  //                       fontFamily: 'inter',
                  //                       fontSize: 12.0,
                  //                       color:
                  //                           //  Provider.of<NavigationProvider>(
                  //                           //                 context)
                  //                           //             .themeMode ==
                  //                           //         ThemeMode.dark
                  //                           //     ? Colors.black
                  //                           //     :
                  //                           Colors.white))),
                  //         ),
                  //       ],
                  //     );
                  //   },
                  // );

                  // Implement logout functionality
                },
              ),
              Spacer(),
              // FutureBuilder<PackageInfo>(
              //   future: PackageInfo.fromPlatform(),
              //   builder: (context, snapshot) => getVersion(context, snapshot),
              // ),
              SizedBox(
                height: 15.0,
              )
            ],
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              // color: Colors.red,
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Primary Market',
                    style: TextStyle(
                        fontSize: 25,
                        letterSpacing: 1.2,
                        fontFamily: 'Kiro',
                        fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    'Start Your Investment Journey',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'inter'),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    'Invest in IPO, zero commission Direct Mutual Funds, Sovereign Gold Bonds, and Government Bills',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, fontFamily: 'inter'),
                  ),
                  // ElevatedButton(
                  //     onPressed: () {
                  //       BlocProvider.of<AuthCookieCubit>(context).loggedOut();
                  //     },
                  //     child: Text('Logout')),
                  Center(
                    child: Text(clientId),
                  ),
                ],
              ),
            ),
            // isLoading
            //     ? const Expanded(child: Center(child: loadingProgress()))
            //     :
            dashboardData.isEmpty
                ? Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text('Something went wrong, Please Retry...'),
                        IconButton(
                            iconSize: 30,
                            splashColor: appPrimeColor,
                            splashRadius: 20,
                            onPressed: () async {
                              // await fetchNovoDashBoardDetails(context: context);
                            },
                            icon: const Icon(Icons.refresh_outlined)),
                      ],
                    ),
                  )
                : Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(40.0),
                      child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 30.0,
                                  mainAxisSpacing: 25.0),
                          itemCount: dashboardData.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: dashboardData[index].status == 'Y'
                                  ? () {
                                      // BlocProvider.of<AuthCookieCubit>(context)
                                      //     .loggedIn();
                                      context
                                          .read<AuthCookieCubit>()
                                          .loggedIn();
                                      // Navigator.push(context, MaterialPageRoute(
                                      //   builder: (context) {
                                      //     return IpoPage();
                                      //   },
                                      // ));
                                      // dashboardData[index].path == '/ipo'
                                      //     ? 1
                                      //     : dashboardData[index].path == '/sgb'
                                      //         ? 2
                                      //         : dashboardData[index].path ==
                                      //                 '/gsec'
                                      //             ? 3
                                      //             : 0;
                                    }
                                  : null,
                              child: Visibility(
                                visible: dashboardData[index].status == 'Y',
                                child: Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.shade200
                                            .withOpacity(0.9),
                                        offset: const Offset(
                                          5.0,
                                          5.0,
                                        ),
                                        blurRadius: 20.0,
                                        spreadRadius: 10.0,
                                      ), //BoxShadow
                                      BoxShadow(
                                        color: Colors.white,
                                        offset: const Offset(
                                          0.0,
                                          0.0,
                                        ),
                                        blurRadius: 0.0,
                                        spreadRadius: 5.0,
                                      ), //BoxShadow
                                    ],
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.network(
                                        '${dashboardData[index].image}',
                                        width:
                                            dashboardData[index].path == '/sgb'
                                                ? 82
                                                : 60,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                const SizedBox(),
                                      ),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      Text(
                                        dashboardData[index].name!,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            fontFamily: 'Kiro'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
