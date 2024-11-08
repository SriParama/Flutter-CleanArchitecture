import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novoapp/core/theme/app_colors.dart';
import 'package:novoapp/core/theme/themeprovider.dart';
import 'package:novoapp/features/auth/presentation/blocs/auth_cookie_cubit/auth_cookie_cubit.dart';
import 'package:novoapp/features/novo/presentation/widgets/customTabBar_widget.dart';
import 'package:novoapp/features/novo/presentation/widgets/gsec_customWidgets/custom_gsecInvestScreen_lisview_widget.dart';
import 'package:provider/provider.dart';

class GSecScreen extends StatefulWidget {
  const GSecScreen({super.key});

  @override
  State<GSecScreen> createState() => _GSecScreenState();
}

class _GSecScreenState extends State<GSecScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  late TabController _gsectabController;
  late TabController _tbillstabController;
  late TabController _sdltabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, initialIndex: 0, vsync: this);
    _gsectabController = TabController(length: 2, vsync: this, initialIndex: 0);
    _tbillstabController =
        TabController(length: 2, vsync: this, initialIndex: 0);
    _sdltabController = TabController(length: 2, vsync: this, initialIndex: 0);
    context.read<AuthCookieCubit>().loggedIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color themeBasedColor =
        Provider.of<NavigationProvider>(context).themeMode == ThemeMode.dark
            ? titleTextColorDark
            : titleTextColorLight;
    return DefaultTabController(
      // animationDuration: Durations.long1,
      // initialIndex: 0,

      length: 3,
      child: Scaffold(
        appBar: AppBar(
          // foregroundColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                Provider.of<NavigationProvider>(context).themeMode ==
                        ThemeMode.dark
                    ? "assets/images/NCB W.png"
                    : "assets/images/NCB B.png",
                width: 28.0,
              ),
              const SizedBox(
                width: 10.0,
              ),
              Text(
                'G-SEC',
                style: TextStyle(
                    color: themeBasedColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Kiro',
                    height: 0.5),
              ),
            ],
          ),

          bottom: TabBar(
            controller: _tabController,
            // onTap: (index) {
            //   // _activeTabIndex.value = index;
            //   // ////////print('_activeTabIndex.value');
            //   // ////////print(_activeTabIndex.value);
            // },
            dividerColor: Colors.red,
            indicatorColor: appPrimeColor,
            dividerHeight: 100,
            labelPadding: const EdgeInsets.all(0),
            tabs: <Widget>[
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      Provider.of<NavigationProvider>(context).themeMode ==
                              ThemeMode.dark
                          ? "assets/images/GOI white.png"
                          : "assets/images/GOI_2.png",
                      width: 24.0,
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    Text('Govt.Bonds',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: themeBasedColor)),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      Provider.of<NavigationProvider>(context).themeMode ==
                              ThemeMode.dark
                          ? "assets/images/GSEC White.png"
                          : "assets/images/GSEC_1.png",
                      width: 24.0,
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    Text('T-Bills',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: themeBasedColor)),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      Provider.of<NavigationProvider>(context).themeMode ==
                              ThemeMode.dark
                          ? "assets/images/SDL White.png"
                          : "assets/images/SDL.png",
                      width: 24.0,
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    Text('SDL',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: themeBasedColor)),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            CustomTabBarWidget(
              tabController: _gsectabController,
              tabname1: 'Invest',
              tabname2: 'Order',
              // titleText: '',
              titleDarkImage: "assets/images/SGB WNovo Icon.png",
              titleLightImage: "assets/images/SGB BNovo Icon.png",
              investScreenTabView: CustomGsecInvestScreenListviewBuilder(),
              orderScreenTabView: Text('Gsec-order'),
              // orderScreenTabView: CustomOrderScreenWidget(
              //   sgbOrderDetialsModel: sgbOrderDetialsModel!,
              //   sgbOrderDetailList: sgbOrderDetailsList!,
              // ),
            ),
            CustomTabBarWidget(
              tabController: _tbillstabController,
              tabname1: 'Invest',
              tabname2: 'Order',
              // titleText: '',
              titleDarkImage: "assets/images/SGB WNovo Icon.png",
              titleLightImage: "assets/images/SGB BNovo Icon.png",
              investScreenTabView: Text('Tbills'),
              orderScreenTabView: Text('tbills order'),
              // orderScreenTabView: CustomOrderScreenWidget(
              //   sgbOrderDetialsModel: sgbOrderDetialsModel!,
              //   sgbOrderDetailList: sgbOrderDetailsList!,
              // ),
            ),
            CustomTabBarWidget(
              tabController: _sdltabController,
              tabname1: 'Invest',
              tabname2: 'Order',
              // titleText: '',
              titleDarkImage: "assets/images/SGB WNovo Icon.png",
              titleLightImage: "assets/images/SGB BNovo Icon.png",
              investScreenTabView: Text('SDL'),
              orderScreenTabView: Text('sdl order'),
              // orderScreenTabView: CustomOrderScreenWidget(
              //   sgbOrderDetialsModel: sgbOrderDetialsModel!,
              //   sgbOrderDetailList: sgbOrderDetailsList!,
              // ),
            ),
          ],
        ),
      ),
    );
  }
}
