import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novoapp/core/ThemeBloc/theme_bloc.dart';
import 'package:novoapp/core/common/appExit_snackbar.dart';
import 'package:novoapp/core/common/globleVariables.dart';
import 'package:novoapp/core/common/show_dialog.dart';
import 'package:novoapp/core/common/show_snackbar.dart';
import 'package:novoapp/core/commonWidgets/errorWidgets/internetErrorWidget.dart';
import 'package:novoapp/core/commonWidgets/errorWidgets/somethingWrongErrorWidget.dart';
import 'package:novoapp/core/commonWidgets/loader.dart';
import 'package:novoapp/core/commonWidgets/loadingAlartBox.dart';
import 'package:novoapp/core/cubits/IndexChange_cubit/index_change_cubit.dart';
import 'package:novoapp/core/cubits/internet_cubit/internet_cubit.dart';
import 'package:novoapp/core/route/onGenerateRoute.dart';
import 'package:novoapp/core/theme/themeprovider.dart';
import 'package:novoapp/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:novoapp/features/novo/presentation/cubit/Sgb_FetchData_Cubit/sgb_fetch_data_cubit.dart';
import 'package:novoapp/features/novo/presentation/pages/G-secScreens/gSecScreen.dart';
import 'package:novoapp/features/novo/presentation/pages/IpoScreens/ipoScreen.dart';
import 'package:novoapp/features/novo/presentation/pages/sgbScreens/sgbScreen.dart';
import 'package:novoapp/main.dart';
import 'package:package_info/package_info.dart';
import 'package:novoapp/core/theme/app_colors.dart';
import 'package:novoapp/core/theme/theme.dart';
import 'package:novoapp/features/auth/presentation/blocs/auth_cookie_cubit/auth_cookie_cubit.dart';
import 'package:novoapp/features/auth/presentation/pages/LogInPages/loginWithPwdPage.dart';
import 'package:novoapp/features/novo/data/novo_data_source/models/novoModel/dashboard_model.dart';
import 'package:novoapp/features/novo/presentation/cubit/Fetch_data_Cubit/fetch_data_cubit.dart';
import 'package:novoapp/features/novo/presentation/pages/ipopage.dart';
import 'package:novoapp/features/novo/presentation/pages/novo_DashBoardScreen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:provider/provider.dart';

class NovoMainScreen extends StatefulWidget {
  // final String cookie;
  static const String routeName = '/dashboard';
  const NovoMainScreen({super.key});

  @override
  State<NovoMainScreen> createState() => _NovoMainScreenState();
}

class _NovoMainScreenState extends State<NovoMainScreen> {
  DashboardModel? dashboardModel;
  List<SegmentArr> dashboardData = [];
  String clientId = '';
  String clientName = '';
  bool drawerisOpen = false;
  bool isDialogShown = false;
  bool isLoggedOut = false;
  DateTime goBackApp = DateTime.now();
  List<Widget>? pagePropagation;
  @override
  void initState() {
    context.read<AuthCookieCubit>().loggedIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getPage(value) {
      switch (value) {
        case "/ipo":
          return const IpoScreen();
        case "/sgb":
          return const SgbScreen();
        case "/gsec":
          return const GSecScreen();
        default:
          return null;
      }
    }

    return BlocListener<InternetCubit, InternetState>(
      listener: (context, state) {
        if (state is InternetDisconnected) {
          OverlayService.showPersistentNotification(
            ' Internet Disconnected',
            () {
              OverlayService.hidePersistentNotification();
            },
          );
          context.read<IndexChangeCubit>().changeIndex(4);
          context.read<AuthCookieCubit>().loggedIn();
          // context.read<SgbFetchDataCubit>().getSGBData();
          context.read<FetchDataCubit>().getDashBoardData();

          // showSnackBar(context, 'No Inter Net');
        } else if (state is InternetConnected) {
          OverlayService.hidePersistentNotification();
          // showSnackBar(context, 'InterNetConnected');
          context.read<AuthCookieCubit>().loggedIn();
          // context.read<SgbFetchDataCubit>().getSGBData();
          context.read<FetchDataCubit>().getDashBoardData();
          // Navigator.pop(context);
          int previosIndex = context.read<IndexChangeCubit>().previousIndex;
          print(previosIndex);
          context.read<IndexChangeCubit>().changeIndex(previosIndex);
        }
      },
      child: BlocListener<AuthCookieCubit, AuthCookieState>(
        listener: (context, state) {
          if (state is AuthCookieInvalid) {
            if (isLoggedOut) {
              showSnackBar(context, LogoutSuccess, Colors.black);
            } else {
              showSnackBar(context, sessionError, primaryRedColor);
            }
            context.read<IndexChangeCubit>().changeIndex(0);
            Navigator.pushNamedAndRemoveUntil(
              context,
              PageConst.loginPage,
              (route) => false,
            );
          } else {}
        },
        child: BlocBuilder<FetchDataCubit, FetchDataState>(
            builder: (context, fetchState) {
          if (fetchState is FetchDataLoaded) {
            try {
              dashboardData = fetchState.dashboardData.segmentArr!
                  .where((e) =>
                      e.status!.toUpperCase() == 'Y' && getPage(e.path) != null)
                  .toList();
              clientId = fetchState.clientId;
              clientName = fetchState.clientName;
              pagePropagation = [
                NovoDashBoardScreen(dashboardData: dashboardData),
                ...dashboardData
                    .map((e) => getPage(e.path))
                    .where((element) => element != null)
                    .cast<Widget>(),
                InternetErrorPage()
              ];

              return _novoPageWidget(dashboardData, clientId, clientName);
            } catch (e) {
              //print('Error occure API');
              //print(e);
              dashboardData = [];
              clientId = '';
              clientName = '';
              return _novoPageWidget(dashboardData, clientId, clientName);
            }
          } else if (fetchState is FetchDataFailure) {
            dashboardData = [];
            clientId = '';
            clientName = '';
            return _novoPageWidget(dashboardData, clientId, clientName);
          } else {
            return const Loader();
          }
        }),
      ),
    );
  }

  _novoPageWidget(
      List<SegmentArr> dashboardData, String clientId, String clientName) {
    // final themeBloc = BlocProvider.of<ThemeBloc>(context);
    // final darkTheme = themeBloc.state.themeMode == ThemeMode.dark;
    final darkTheme =
        Provider.of<NavigationProvider>(context).themeMode == ThemeMode.dark;
    Color themeBasedColor =
        darkTheme ? titleTextColorDark : titleTextColorLight;
    getVersion(context, snapshot) {
      if (snapshot.hasData) {
        return Text('Version: ${snapshot.data!.version}',
            style: darkTheme
                ? ThemeClass.Darktheme.textTheme.bodyMedium
                : ThemeClass.Lighttheme.textTheme.bodyMedium);
      } else {
        return const Text(
            'Version'); // You can display a loading indicator here if needed.
      }
    }

    Future<void> closeLogoutLoadingAlertBox() async {
      isLoggedOut = await context.read<AuthCookieCubit>().loggedOut();
      if (mounted && isLoggedOut) {
        print('yes logout');
        Navigator.of(context).pop();
        showSnackBar(context, LogoutSuccess, Colors.black);
        context.read<IndexChangeCubit>().changeIndex(0);
      }
    }

    willPopScopeFunc(intex) async {
      if (drawerisOpen) {
        Navigator.of(context).pop();
        return false;
      }

      if (isDialogShown) {
        return true; // Allow the back button to exit
      }
      if (DateTime.now().isBefore(goBackApp)) {
        SystemNavigator.pop();
        return true;
      }

      if (intex != 0) {
        context.read<IndexChangeCubit>().changeIndex(0);
        return false;
      }

      goBackApp = DateTime.now().add(const Duration(seconds: 2));
      appExit(context);

      return false;
    }

    return BlocBuilder<IndexChangeCubit, int>(
      builder: (context, intex) {
        return PopScope(
            canPop: false,
            onPopInvoked: (didPop) => willPopScopeFunc(intex),
            child: Scaffold(
                onDrawerChanged: (isOpened) => drawerisOpen = isOpened,
                drawerEdgeDragWidth: MediaQuery.of(context).size.width * 0.10,
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.transparent,
                      systemNavigationBarDividerColor: Colors.transparent,
                      statusBarIconBrightness:
                          darkTheme ? Brightness.light : Brightness.dark),
                  elevation: 0,
                  title: GestureDetector(
                    onTap: () {
                      context.read<IndexChangeCubit>().changeIndex(0);
                    },
                    child: Image.asset(
                      darkTheme
                          ? 'assets/images/novoLogoBlack.png'
                          : 'assets/images/Novo Transp.png',
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
                            color: themeBasedColor,
                            size: 25,
                          ), // Use the menu icon for the drawer
                          onPressed: () {
                            Scaffold.of(context)
                                .openDrawer(); // Open the drawer
                          },
                          color: themeBasedColor);
                    },
                  ),
                ),
                drawer: Drawer(
                  child: Column(
                    children: <Widget>[
                      DrawerHeader(
                          decoration: BoxDecoration(
                              color: darkTheme
                                  ? titleTextColorLight
                                  : appPrimeColor),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 60,
                                    height: 60,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                        color: darkTheme
                                            ? appPrimeColor
                                            : const Color.fromRGBO(
                                                187, 222, 251, 1),
                                        borderRadius:
                                            BorderRadius.circular(50.0)),
                                    child: FittedBox(
                                      child: Text(
                                        clientName,
                                        style: TextStyle(
                                            color: darkTheme
                                                ? const Color.fromRGBO(
                                                    187, 222, 251, 1)
                                                : appPrimeColor,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Kiro'),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Provider.of<NavigationProvider>(context,
                                              listen: false)
                                          .toggleTheme(context);
                                      // themeBloc.add(ToggleTheme());
                                    },
                                    icon: Icon(
                                      darkTheme
                                          ? Icons.dark_mode
                                          : Icons.light_mode,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                              Text(clientId,
                                  style: ThemeClass
                                      .Darktheme.textTheme.headlineSmall),
                            ],
                          )),
                      ListTile(
                        dense: true,
                        leading: Image.asset(
                          "assets/images/layout.png",
                          width: 20.0,
                          color: darkTheme
                              ? titleTextColorDark
                              : titleTextColorLight,
                        ),
                        title: Text("NOVO",
                            style: darkTheme
                                ? ThemeClass.Darktheme.textTheme.labelMedium!
                                    .copyWith(
                                        color: intex == 0
                                            ? darkTheme
                                                ? Colors.blue.shade400
                                                : appPrimeColor
                                            : ThemeClass.Darktheme.textTheme
                                                .labelMedium!.color)
                                : ThemeClass.Lighttheme.textTheme.labelMedium!
                                    .copyWith(
                                        color: intex == 0
                                            ? appPrimeColor
                                            : ThemeClass.Lighttheme.textTheme
                                                .labelMedium!.color)),
                        onTap: () {
                          context.read<IndexChangeCubit>().changeIndex(0);
                          Navigator.pop(context);
                        },
                      ),
                      ...dashboardData.map(
                        (e) => ListTile(
                          dense: true,
                          leading: Image.network(
                            darkTheme ? "${e.darkThemeImage}" : "${e.image}",
                            width: 20.0,
                          ),
                          title: Text('${e.name}',
                              style: darkTheme
                                  ? ThemeClass.Darktheme.textTheme.labelMedium!
                                      .copyWith(
                                          color: intex ==
                                                  dashboardData.indexOf(e) + 1
                                              ? darkTheme
                                                  ? Colors.blue.shade400
                                                  : appPrimeColor
                                              : ThemeClass.Darktheme.textTheme
                                                  .labelMedium!.color)
                                  : ThemeClass.Lighttheme.textTheme.labelMedium!
                                      .copyWith(
                                          color: intex ==
                                                  dashboardData.indexOf(e) + 1
                                              ? appPrimeColor
                                              : ThemeClass.Lighttheme.textTheme
                                                  .labelMedium!.color)),
                          onTap: () {
                            context
                                .read<IndexChangeCubit>()
                                .changeIndex(dashboardData.indexOf(e) + 1);
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      ListTile(
                        dense: true,
                        leading: Icon(
                          CupertinoIcons.power,
                          size: 17,
                          color: themeBasedColor,
                        ),
                        title: Text("Logout",
                            style: darkTheme
                                ? ThemeClass.Darktheme.textTheme.labelMedium
                                : ThemeClass.Lighttheme.textTheme.labelMedium),
                        onTap: () {
                          customDialogBox(context, 'Do you want to Logout ?',
                              closeLogoutLoadingAlertBox);
                        },
                      ),
                      const Spacer(),
                      FutureBuilder<PackageInfo>(
                        future: PackageInfo.fromPlatform(),
                        builder: (context, snapshot) =>
                            getVersion(context, snapshot),
                      ),
                      const SizedBox(
                        height: 15.0,
                      )
                    ],
                  ),
                ),
                bottomNavigationBar: intex == 0 ||
                        intex == 4 ||
                        dashboardData.isEmpty
                    ? const SizedBox()
                    : CurvedNavigationBar(
                        height: 60,
                        backgroundColor: Colors.transparent,
                        color: appPrimeColor,
                        animationDuration: const Duration(milliseconds: 500),
                        index: intex - 1 < 0 ? 0 : intex - 1,
                        onTap: (newValue) {
                          intex = newValue + 1;
                          context.read<IndexChangeCubit>().changeIndex(intex);
                        },
                        items: <Widget>[
                            ...dashboardData.map(
                              (e) => Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    e.path == '/ipo'
                                        ? Image.asset(
                                            'assets/images/IPO WNovo Icon.png',
                                            width: 27,
                                          )
                                        : e.path == '/sgb'
                                            ? Image.asset(
                                                'assets/images/SGB WNovo Icon.png',
                                                width: 34,
                                              )
                                            : e.path == '/gsec'
                                                ? Image.asset(
                                                    'assets/images/NCB W.png',
                                                    width: 30,
                                                  )
                                                : const SizedBox(),
                                    const SizedBox(
                                      height: 3.0,
                                    ),
                                    Text(
                                      e.name!,
                                      style: const TextStyle(
                                          fontSize: 10,
                                          color: Colors.white,
                                          fontFamily: 'Kiro'),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ]),
                body: pagePropagation != null
                    ? pagePropagation![intex]
                    : const SomethingWentWrongErrorPage()));
      },
    );
  }
}
