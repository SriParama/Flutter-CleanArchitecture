import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novoapp/core/ThemeBloc/theme_bloc.dart';
import 'package:novoapp/core/common/globleVariables.dart';
import 'package:novoapp/core/commonWidgets/errorWidgets/somethingWrongErrorWidget.dart';
import 'package:novoapp/core/theme/app_colors.dart';
import 'package:novoapp/core/theme/theme.dart';
import 'package:novoapp/core/theme/themeprovider.dart';
import 'package:novoapp/features/novo/data/novo_data_source/models/sgbModel/sgb_OrderDetails_model.dart';
import 'package:novoapp/features/novo/presentation/cubit/Sgb_FetchData_Cubit/sgb_fetch_data_cubit.dart';
import 'package:novoapp/features/novo/presentation/widgets/custom_SearchBar.dart';
import 'package:novoapp/features/novo/presentation/widgets/sgb_customWidget/custom_historyinfo.dart';
import 'package:provider/provider.dart';

class CustomOrderScreenWidget extends StatefulWidget {
  final SGBorderDetialsModel sgbOrderDetialsModel;
  final List<SgbOrderHistoryArr> sgbOrderDetailList;
  const CustomOrderScreenWidget(
      {super.key,
      required this.sgbOrderDetialsModel,
      required this.sgbOrderDetailList});

  @override
  State<CustomOrderScreenWidget> createState() =>
      _CustomOrderScreenWidgetState();
}

class _CustomOrderScreenWidgetState extends State<CustomOrderScreenWidget> {
  // void filterdata(String value) {
  //   if (value.isEmpty) {
  //     filterdatalist = sgbHistoryDetailList!;
  //   } else {
  //     filterdatalist = sgbHistoryDetailList!
  //         .where((data) =>
  //             data.orderStatus
  //                 .toString()
  //                 .toLowerCase()
  //                 .contains(value.toLowerCase()) ||
  //             data.name
  //                 .toString()
  //                 .toLowerCase()
  //                 .contains(value.toLowerCase()) ||
  //             data.orderDate
  //                 .toString()
  //                 .toLowerCase()
  //                 .contains(value.toLowerCase()))
  //         .toList();
  //   }
  //   setState(() {});
  // }

  late List<SgbOrderHistoryArr> filterdatalist;
  String searchtext = "";

  @override
  void initState() {
    super.initState();
    // context.read<SgbFetchDataCubit>().getSGBData();
    filterdatalist = widget.sgbOrderDetailList;
  }

  void searchdata(String value) {
    searchtext = value;
    setState(() {
      if (searchtext.isEmpty) {
        filterdatalist = widget.sgbOrderDetailList;
      } else {
        filterdatalist = widget.sgbOrderDetailList
            .where((data) =>
                data.orderStatus
                    .toString()
                    .toLowerCase()
                    .contains(value.toLowerCase()) ||
                data.name
                    .toString()
                    .toLowerCase()
                    .contains(value.toLowerCase()) ||
                data.orderDate
                    .toString()
                    .toLowerCase()
                    .contains(value.toLowerCase()))
            .toList();
      }
    });
  }

  statusColorFun(SgbOrderHistoryArr filterdatalist, context) {
    if (filterdatalist.statusColor == 'G') {
      return primaryGreenColor;
    } else if (filterdatalist.statusColor == 'R') {
      return primaryRedColor;
    } else {
      return
          //  Provider.of<NavigationProvider>(context).themeMode ==
          //         ThemeMode.dark
          //     ? titleTextColorDark
          //     :
          titleTextColorLight;
    }
  }

  @override
  Widget build(BuildContext context) {
    // final themeBloc = BlocProvider.of<ThemeBloc>(context);
    // final darkTheme = themeBloc.state.themeMode == ThemeMode.dark;
    final darkTheme =
        Provider.of<NavigationProvider>(context).themeMode == ThemeMode.dark;
    Color themeBasedColor =
        darkTheme ? titleTextColorDark : titleTextColorLight;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SearchFeild(
            visible: widget.sgbOrderDetialsModel.historyFound == 'Y' &&
                widget.sgbOrderDetailList.isNotEmpty,
            onChange: searchdata,
          ),
          widget.sgbOrderDetialsModel.historyFound == 'Y'
              ? filterdatalist.isEmpty
                  ? Expanded(
                      child: Center(
                        child: Text('Record Not Found'),
                      ),
                    )
                  : Expanded(
                      child: ListView.separated(
                        // controller: _controller,
                        separatorBuilder: (context, index) {
                          return Divider(
                            color: darkTheme
                                ? Colors.white10
                                : const Color.fromRGBO(235, 237, 236, 1),
                            thickness: 1.5,
                          );
                        },
                        itemCount: filterdatalist.length,
                        itemBuilder: (context, index) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Tranche',
                                        style: darkTheme
                                            ? ThemeClass.Darktheme.textTheme
                                                .displayMedium
                                            : ThemeClass.Lighttheme.textTheme
                                                .displayMedium,
                                      ),
                                      SizedBox(
                                        // color: Colors.red,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.52,
                                        child: Text(
                                          filterdatalist[index].name,
                                          overflow: TextOverflow.visible,
                                          softWrap: true,
                                          style: darkTheme
                                              ? ThemeClass.Darktheme.textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w500)
                                              : ThemeClass.Lighttheme.textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w500),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Ordered Date',
                                        style: darkTheme
                                            ? ThemeClass.Darktheme.textTheme
                                                .displayMedium
                                            : ThemeClass.Lighttheme.textTheme
                                                .displayMedium,
                                      ),
                                      Text(
                                        filterdatalist[index].orderDate,
                                        style: darkTheme
                                            ? ThemeClass
                                                .Darktheme.textTheme.bodyMedium
                                            : ThemeClass.Lighttheme.textTheme
                                                .bodyMedium,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 3.0,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Int.RefNo',
                                        style: darkTheme
                                            ? ThemeClass.Darktheme.textTheme
                                                .displayMedium
                                            : ThemeClass.Lighttheme.textTheme
                                                .displayMedium,
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.52,
                                        child: Text(
                                          filterdatalist[index].isin,
                                          overflow: TextOverflow.visible,
                                          softWrap: true,
                                          style: darkTheme
                                              ? ThemeClass.Darktheme.textTheme
                                                  .bodyMedium
                                              : ThemeClass.Lighttheme.textTheme
                                                  .bodyMedium,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Status',
                                        style: darkTheme
                                            ? ThemeClass.Darktheme.textTheme
                                                .displayMedium
                                            : ThemeClass.Lighttheme.textTheme
                                                .displayMedium,
                                      ),
                                      Text(
                                        filterdatalist[index].orderStatus,
                                        style: TextStyle(
                                            fontFamily: 'inter',
                                            color: statusColorFun(
                                                filterdatalist[index], context),
                                            fontSize: 12,
                                            height: 1.4),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 3.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Exch OrderNo',
                                        style: darkTheme
                                            ? ThemeClass.Darktheme.textTheme
                                                .displayMedium
                                            : ThemeClass.Lighttheme.textTheme
                                                .displayMedium,
                                      ),
                                      Text(
                                        filterdatalist[index].exchOrderNo,
                                        style: darkTheme
                                            ? ThemeClass
                                                .Darktheme.textTheme.bodyMedium
                                            : ThemeClass.Lighttheme.textTheme
                                                .bodyMedium,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Units',
                                        style: darkTheme
                                            ? ThemeClass.Darktheme.textTheme
                                                .displayMedium
                                            : ThemeClass.Lighttheme.textTheme
                                                .displayMedium,
                                      ),
                                      Text(
                                        filterdatalist[index]
                                            .requestedUnit
                                            .toString(),
                                        style: darkTheme
                                            ? ThemeClass
                                                .Darktheme.textTheme.bodyMedium
                                            : ThemeClass.Lighttheme.textTheme
                                                .bodyMedium,
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 3.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Unit price',
                                        style: darkTheme
                                            ? ThemeClass.Darktheme.textTheme
                                                .displayMedium
                                            : ThemeClass.Lighttheme.textTheme
                                                .displayMedium,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            rsFormat.format(
                                                filterdatalist[index]
                                                    .requestedUnitPrice),
                                            style: darkTheme
                                                ? ThemeClass.Darktheme.textTheme
                                                    .bodyMedium
                                                : ThemeClass.Lighttheme
                                                    .textTheme.bodyMedium,
                                          ),
                                          SizedBox(
                                            width: 5.0,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              sgbHistoryPriceInfoDailog(
                                                  filterdatalist[index],
                                                  context);
                                            },
                                            child: Icon(
                                              CupertinoIcons.info,
                                              size: 15,
                                              color: darkTheme
                                                  ? Colors.blue
                                                  : appPrimeColor,
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Total',
                                        style: darkTheme
                                            ? ThemeClass.Darktheme.textTheme
                                                .displayMedium
                                            : ThemeClass.Lighttheme.textTheme
                                                .displayMedium,
                                      ),
                                      Text(
                                        rsFormat.format(filterdatalist[index]
                                            .requestedAmount),
                                        style: darkTheme
                                            ? ThemeClass
                                                .Darktheme.textTheme.bodyMedium
                                            : ThemeClass.Lighttheme.textTheme
                                                .bodyMedium,
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                    )
              : widget.sgbOrderDetialsModel.historyFound == 'N' &&
                      widget.sgbOrderDetialsModel.historyFound.isNotEmpty &&
                      widget.sgbOrderDetialsModel.historynoDataText.isNotEmpty
                  ? Expanded(
                      child: Center(
                        child:
                            Text(widget.sgbOrderDetialsModel.historynoDataText),
                      ),
                    )
                  : Expanded(child: SomethingWentWrongErrorPage()),
        ],
      ),
    );
  }
}
