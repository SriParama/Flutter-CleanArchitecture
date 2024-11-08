import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novoapp/core/ThemeBloc/theme_bloc.dart';
import 'package:novoapp/core/theme/app_colors.dart';
import 'package:novoapp/core/theme/theme.dart';
import 'package:novoapp/core/theme/themeprovider.dart';
import 'package:novoapp/features/novo/data/novo_data_source/models/sgbModel/sgb_InvestDetails_model.dart';
import 'package:provider/provider.dart';

class CustomTabBarWidget extends StatefulWidget {
  TabController tabController;
  String? titleText;
  String tabname1;
  String tabname2;
  String titleDarkImage;
  String titleLightImage;
  Widget? investScreenTabView;
  Widget? orderScreenTabView;
  // SgbMasterDetailsModel? sgbMasterDetailsModel;
  CustomTabBarWidget({
    super.key,
    required this.tabController,
    this.titleText,
    required this.tabname1,
    required this.tabname2,
    required this.titleDarkImage,
    required this.titleLightImage,
    this.investScreenTabView,
    this.orderScreenTabView,
    // this.sgbMasterDetailsModel,
  });

  @override
  State<CustomTabBarWidget> createState() => _CustomTabBarWidgetState();
}

class _CustomTabBarWidgetState extends State<CustomTabBarWidget>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    // widget.tabController =
    //     TabController(length: 2, vsync: this, initialIndex: 0);
    // getSGBMasterDetails();
    super.initState();
  }

  // List<SgbDetail>? sgbMasterDetialsList;
  // getSGBMasterDetails() {
  //   sgbMasterDetialsList = widget.sgbMasterDetailsModel!.sgbDetail;
  // }

  @override
  Widget build(BuildContext context) {
    // final themeBloc = BlocProvider.of<ThemeBloc>(context);
    // final darkTheme = themeBloc.state.themeMode == ThemeMode.dark;
    final darkTheme =
        Provider.of<NavigationProvider>(context).themeMode == ThemeMode.dark;
    Color themeBasedColor =
        darkTheme ? titleTextColorDark : titleTextColorLight;
    // final getTheme = GetTheme();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.titleText == null
                ? SizedBox()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Image.asset(
                        darkTheme
                            ? widget.titleDarkImage
                            : widget.titleLightImage,
                        width: 34.0,
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        widget.titleText!,
                        style: darkTheme
                            ? ThemeClass.Darktheme.textTheme.headlineMedium
                            : ThemeClass.Lighttheme.textTheme.headlineMedium,
                      ),
                    ],
                  ),
            const SizedBox(
              height: 12.0,
            ),
            Container(
              height: 35,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(
                  15.0,
                ),
              ),
              child: TabBar(
                controller: widget.tabController,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    15.0,
                  ),
                  color: appPrimeColor,
                ),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                labelStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'inter'),
                tabs: [
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.tabname1),
                        // const SizedBox(
                        //   width: 5.0,
                        // ),
                        // sgbPageLoading
                        //     ? const SizedBox()
                        //     : sgbMasterDataApi == null ||
                        //             sgbMasterDataApi!.sgbDetail == null ||
                        //             sgbMasterDataApi!.investCount
                        //                 .toString()
                        //                 .isEmpty ||
                        //             sgbMasterDataApi!.investCount < 0 ||
                        //             sgbMasterDataApi!.investCount == 0 ||
                        //             sgbMasterDataApi!.masterFound != 'Y'
                        //         ? const SizedBox()
                        //         : TabinfoContainer(
                        //             tabCount:
                        //                 '${sgbMasterDataApi!.investCount}',
                        //           )
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.tabname2),
                        // const SizedBox(
                        //   width: 5.0,
                        // ),
                        // sgbPageLoading
                        //     ? const SizedBox()
                        //     : sgbHistoryDataApi == null ||
                        //             sgbHistoryDataApi!.sgbOrderHistoryArr ==
                        //                 null ||
                        //             sgbHistoryDataApi!.orderCount
                        //                 .toString()
                        //                 .isEmpty ||
                        //             sgbHistoryDataApi!.orderCount < 0 ||
                        //             sgbHistoryDataApi!.orderCount == 0 ||
                        //             sgbHistoryDataApi!.historyFound != 'Y'
                        //         ? const SizedBox()
                        //         : TabinfoContainer(
                        //             tabCount:
                        //                 '${sgbHistoryDataApi?.orderCount}',
                        //           )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: widget.tabController,
                children: [
                  widget.investScreenTabView ??
                      Center(
                        child: CircularProgressIndicator(),
                      ),
                  widget.orderScreenTabView ??
                      Center(
                        child: CircularProgressIndicator(),
                      ),
                  // Center(
                  //   child: Text('SGB History Screen'),
                  // )
                  // sgbPageLoading
                  //     ? const Center(
                  //         child: loadingProgress(),
                  //       )
                  //     : sgbMasterDataApi == null ||
                  //             sgbMasterDataApi!.masterFound.isEmpty
                  //         ? Column(
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             crossAxisAlignment: CrossAxisAlignment.center,
                  //             children: [
                  //               const Text(
                  //                   'Something went wrong, Please Retry...'),
                  //               IconButton(
                  //                   iconSize: 30,
                  //                   splashColor: appPrimeColor,
                  //                   splashRadius: 20,
                  //                   onPressed: () async {
                  //                     await fetchSbgDetailsInAPI(context);
                  //                   },
                  //                   icon: const Icon(Icons.refresh_outlined))
                  //             ],
                  //           )
                  //         :
                  //         // first tab bar view widget
                  //         !(sgbMasterDataApi!.masterFound == 'Y' ||
                  //                 sgbMasterDataApi!.masterFound == 'N')
                  //             ? Column(
                  //                 mainAxisAlignment: MainAxisAlignment.center,
                  //                 crossAxisAlignment: CrossAxisAlignment.center,
                  //                 children: [
                  //                   const Text(
                  //                       'Something went wrong, Please Retry...'),
                  //                   IconButton(
                  //                       iconSize: 30,
                  //                       splashColor: appPrimeColor,
                  //                       splashRadius: 20,
                  //                       onPressed: () async {
                  //                         await fetchSbgDetailsInAPI(context);
                  //                       },
                  //                       icon:
                  //                           const Icon(Icons.refresh_outlined))
                  //                 ],
                  //               )
                  //             : SgbActiveScreen(
                  //                 sgbMasterData: sgbMasterDataApi,
                  //               ),

                  // //History tab
                  // sgbPageLoading
                  //     ? const Center(
                  //         child: loadingProgress(),
                  //       )
                  //     : sgbHistoryDataApi == null ||
                  //             sgbHistoryDataApi!.historyFound.isEmpty
                  //         ? Column(
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             crossAxisAlignment: CrossAxisAlignment.center,
                  //             children: [
                  //               const Text(
                  //                   'Something went wrong, Please Retry...'),
                  //               IconButton(
                  //                   iconSize: 30,
                  //                   splashColor: appPrimeColor,
                  //                   splashRadius: 20,
                  //                   onPressed: () async {
                  //                     await fetchSbgDetailsInAPI(context);
                  //                   },
                  //                   icon: const Icon(Icons.refresh_outlined))
                  //             ],
                  //           )
                  //         : !(sgbHistoryDataApi!.historyFound == 'Y' ||
                  //                 sgbHistoryDataApi!.historyFound == 'N')
                  //             ? Column(
                  //                 mainAxisAlignment: MainAxisAlignment.center,
                  //                 crossAxisAlignment: CrossAxisAlignment.center,
                  //                 children: [
                  //                   const Text(
                  //                       'Something went wrong, Please Retry...'),
                  //                   IconButton(
                  //                       iconSize: 30,
                  //                       splashColor: appPrimeColor,
                  //                       splashRadius: 20,
                  //                       onPressed: () async {
                  //                         await fetchSbgDetailsInAPI(context);
                  //                       },
                  //                       icon:
                  //                           const Icon(Icons.refresh_outlined))
                  //                 ],
                  //               )
                  //             : SgbappliedPage(
                  //                 sgbHistoryData: sgbHistoryDataApi,
                  //               ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
