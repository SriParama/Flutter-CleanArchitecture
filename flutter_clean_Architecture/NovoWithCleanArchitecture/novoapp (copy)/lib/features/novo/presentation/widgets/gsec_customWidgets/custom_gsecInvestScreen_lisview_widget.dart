import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novoapp/core/ThemeBloc/theme_bloc.dart';
import 'package:novoapp/core/commonWidgets/errorWidgets/somethingWrongErrorWidget.dart';
import 'package:novoapp/core/commonWidgets/loader.dart';
import 'package:novoapp/core/route/onGenerateRoute.dart';
import 'package:novoapp/core/theme/app_colors.dart';
import 'package:novoapp/core/theme/theme.dart';
import 'package:novoapp/core/theme/themeprovider.dart';
import 'package:novoapp/features/novo/data/novo_data_source/models/sgbModel/sgb_InvestDetails_model.dart';
import 'package:novoapp/features/novo/presentation/cubit/Gsec_fetch_data_Cubit/gsec_fetch_data_cubit.dart';
import 'package:novoapp/features/novo/presentation/cubit/Sgb_FetchData_Cubit/sgb_fetch_data_cubit.dart';
import 'package:novoapp/features/novo/presentation/widgets/custom_SearchBar.dart';
import 'package:novoapp/features/novo/presentation/widgets/custom_disclaimar_Footer.dart';
import 'package:provider/provider.dart';

class CustomGsecInvestScreenListviewBuilder extends StatefulWidget {
  // final String disclimar;
  // final SGBinvestDetailsModel sgbMasterDetailsModel;
  // final List<SgbDetail> sgbDetailList;
  // final dynamic accountBalance;

  const CustomGsecInvestScreenListviewBuilder({
    Key? key,
    // required this.disclimar,
    // required this.sgbMasterDetailsModel,
    // required this.sgbDetailList,
    // required this.accountBalance
  }) : super(key: key);

  @override
  _CustomGsecInvestScreenListviewBuilderState createState() =>
      _CustomGsecInvestScreenListviewBuilderState();
}

class _CustomGsecInvestScreenListviewBuilderState
    extends State<CustomGsecInvestScreenListviewBuilder> {
  // late List<SgbDetail> filterdatalist;
  // String searchtext = "";

  // @override
  // void initState() {
  //   super.initState();
  //   // context.read<SgbFetchDataCubit>().getSGBData();
  //   filterdatalist = widget.sgbDetailList;
  // }

  // void searchdata(String value) {
  //   searchtext = value;
  //   setState(() {
  //     if (searchtext.isEmpty) {
  //       filterdatalist = widget.sgbDetailList;
  //     } else {
  //       filterdatalist = widget.sgbDetailList
  //           .where((data) => data.symbol
  //               .toString()
  //               .toLowerCase()
  //               .contains(searchtext.toLowerCase()))
  //           .toList();
  //     }
  //   });
  // }

  // buttonVisibleFunc(SgbDetail filterdataList) {
  //   if (filterdataList.buttonText.isNotEmpty &&
  //       filterdataList.buttonText != '' &&
  //       filterdataList.actionFlag != '' &&
  //       filterdataList.actionFlag.isNotEmpty) {
  //     return true;
  //   }

  //   return false;
  // }

  // buttonDisableFunc(SgbDetail filterdataList) {
  //   if (!(filterdataList.actionFlag == 'U' ||
  //           filterdataList.actionFlag == 'P' ||
  //           filterdataList.actionFlag == 'B' ||
  //           filterdataList.actionFlag == 'M' ||
  //           filterdataList.actionFlag == 'A' ||
  //           filterdataList.actionFlag == 'C') ||
  //       filterdataList.disableActionBtn == true) {
  //     return true;
  //   }
  //   return false;
  // }

  // buttonColorFunc(SgbDetail filterdataList) {
  //   if ((filterdataList.actionFlag == 'P' ||
  //           filterdataList.actionFlag == 'B') &&
  //       filterdataList.disableActionBtn == false) {
  //     return appPrimeColor;
  //   } else if ((filterdataList.actionFlag == 'M' ||
  //           filterdataList.actionFlag == 'A' ||
  //           filterdataList.actionFlag == 'U' ||
  //           filterdataList.actionFlag == 'C') &&
  //       filterdataList.disableActionBtn == false) {
  //     return modifyButtonColor;
  //   } else if (filterdataList.disableActionBtn == false) {
  //     return appPrimeColor;
  //   }
  // }

  // onSubmit(SgbDetail sgbMasterDetails, dynamic accountBalance) {
  //   Navigator.pushNamed(context, PageConst.sgbPlaceOrderScreen, arguments: {
  //     'SgbDetails': sgbMasterDetails,
  //     'accountbalance': accountBalance
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // final themeBloc = BlocProvider.of<ThemeBloc>(context);
    // final darkTheme = themeBloc.state.themeMode == ThemeMode.dark;
    // final darkTheme =
    //     Provider.of<NavigationProvider>(context).themeMode == ThemeMode.dark;
    // Color themeBasedColor =
    //     darkTheme ? titleTextColorDark : titleTextColorLight;

    return BlocBuilder<GsecFetchDataCubit, GsecFetchDataState>(
      builder: (context, state) {
        // print(state is GsecInvestDataLoaded);
        // print(state.props);
        // var v = context.read<GsecFetchDataCubit>().getGsecInvestData();
        // print(v);
        if (state is GsecInvestDataLoaded) {
          print('++++++++++++');
          print(state.gsecInvestDetailsModel.disclaimer);
          return _gsecInvestOrderWidget();
        } else if (state is GsecInvestDataFailed) {
          print('Gsec Data Failed to get');
          return _gsecInvestOrderWidget();
        } else if (state is GsecInvestDataLoading) {
          print('loading');
          return Loader();
        } else if (state is GsecOrderDataLoaded) {
          print('order data');
          print(state.gsecOrderDetailsModel.sdlhistoryFound);
          return _gsecInvestOrderWidget();
        } else {
          print(state);
          print('else............');
          return Loader();
        }
      },
    );
  }

  Widget _gsecInvestOrderWidget() {
    final darkTheme =
        Provider.of<NavigationProvider>(context).themeMode == ThemeMode.dark;
    Color themeBasedColor =
        darkTheme ? titleTextColorDark : titleTextColorLight;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SearchFeild(
            visible: true,
            // widget.sgbMasterDetailsModel.masterFound == 'Y' &&
            //     widget.sgbDetailList.isNotEmpty,
            onChange: () {},
          ),
          SizedBox(height: 5),
          // widget.sgbMasterDetailsModel.masterFound == 'Y'
          //     ? filterdatalist.isEmpty
          //         ? Expanded(
          //             child: Center(
          //               child: Text('Record Not Found'),
          //             ),
          //           )
          //         :

          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return Divider(
                  color: Provider.of<NavigationProvider>(context).themeMode ==
                          ThemeMode.dark
                      ? Colors.white10 // Light mode
                      : const Color.fromRGBO(235, 237, 236, 1),
                  thickness: 1.5,
                );
              },
              itemCount: 10 + 1,
              itemBuilder: (context, index) {
                if (index < 10) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.65,
                                        child: Text(
                                          'kjhdf',
                                          // filterdatalist[index].name!,
                                          style: TextStyle(
                                              fontFamily: 'inter',
                                              color: themeBasedColor,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                              height: 1.5),
                                        ),
                                      )),
                                  RichText(
                                    text: TextSpan(
                                      text: 'Indicative yield  ',
                                      style: TextStyle(
                                          fontFamily: 'inter',
                                          fontSize: 12,
                                          color: subTitleTextColor),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: 'lksdfl',
                                            // filterdatalist[index]
                                            //     .indicativeYield,
                                            // '\u{20B9}${filterdatalist[index].unitPrice.toString()}',
                                            style: TextStyle(
                                                fontSize: 12 - 1,
                                                height: 1.4,
                                                color: themeBasedColor)),
                                      ],
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: 'Unit Limits  ',
                                      style: TextStyle(
                                          fontFamily: 'inter',
                                          fontSize: 12,
                                          color: subTitleTextColor),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: '1-10',
                                            // rsFormat.format(
                                            // "${filterdatalist[index].minBidQuantity}-${filterdatalist[index].maxBidQuantity}",
                                            // '\u{20B9}${filterdatalist[index].unitPrice.toString()}',
                                            style: TextStyle(
                                                fontSize: 12 - 1,
                                                height: 1.4,
                                                color: themeBasedColor)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Visibility(
                              // visible: buttonVisibleFun(filterdatalist[index]),
                              visible: true,
                              child: SizedBox(
                                  // height: 28,
                                  width: 100,
                                  child: MaterialButton(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      elevation: 2,
                                      disabledColor: Colors.grey,
                                      disabledTextColor: Colors.white70,
                                      // minWidth: 100,
                                      // height: 15,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      onPressed: () {},
                                      color: appPrimeColor,
                                      // color:

                                      // buttonColorFunc(
                                      //     filterdatalist[index]),
                                      // onPressed: disabelButtonFun(
                                      //         filterdatalist[index])
                                      //     ? null
                                      //     : () {
                                      //         onSubmit(filterdatalist[index]);
                                      //       },
                                      child: Text(
                                        'ButtonText',
                                        // filterdatalist[index].buttonText!,
                                        maxLines: 1,
                                        // softWrap: false,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color:
                                                //  filterdatalist[index]
                                                //                 .actionFlag ==
                                                //             'M' ||
                                                //         filterdatalist[index]
                                                //                     .actionFlag ==
                                                //                 'U' &&
                                                //             filterdatalist[index]
                                                //                     .disableActionBtn ==
                                                //                 false
                                                //     ? appPrimeColor
                                                //     :
                                                Colors.white),
                                      ))),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: 'Amount  ',
                                style: TextStyle(
                                    fontFamily: 'inter',
                                    fontSize: 12,
                                    color: subTitleTextColor),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: '2003',
                                      //  filterdatalist[index].amount! > 0
                                      //     ? rsFormat.format(
                                      //         filterdatalist[index].amount)
                                      //     : "${filterdatalist[index].amount}",
                                      style: TextStyle(
                                          fontFamily: 'inter',
                                          fontSize: 12 - 1,
                                          height: 1.4,
                                          color: themeBasedColor)),
                                ],
                              ),
                            ),
                            FittedBox(
                              child: Text('endDateWithTime',
                                  // filterdatalist[index].endDateWithTime!,
                                  style: TextStyle(
                                    fontFamily: 'inter',
                                    fontSize: 12 - 1,
                                    color: themeBasedColor,
                                  )),
                            )
                          ],
                        )
                      ],
                    ),
                  );
                } else {
                  return Column(
                    children: [
                      SizedBox(
                        height: 20.0,
                      ),
                      // Visibility(
                      //   visible:

                      //   widget.ncbDisclaimer.isNotEmpty &&
                      //       (widget.ncbMasterFound == 'Y' ||
                      //           widget.ncbMasterFound == 'N'),
                      //   child: NovoFooterWidget(
                      //       disclimerText: widget.ncbDisclaimer),
                      // ),
                      // SizedBox(
                      //   height: 20.0,
                      // ),
                      // const Footer(),
                    ],
                  );
                }
              },
            ),
          )
          // : widget.sgbMasterDetailsModel.masterFound == 'N' &&
          //         widget.sgbMasterDetailsModel.masterFound.isNotEmpty &&
          //         widget.sgbMasterDetailsModel.noDataText.isNotEmpty
          //     ? Expanded(
          //         child: Center(
          //           child: Text(widget.sgbMasterDetailsModel.noDataText),
          //         ),
          //       )
          //     : Expanded(child: SomethingWentWrongErrorPage()),
        ],
      ),
    );
  }
}
