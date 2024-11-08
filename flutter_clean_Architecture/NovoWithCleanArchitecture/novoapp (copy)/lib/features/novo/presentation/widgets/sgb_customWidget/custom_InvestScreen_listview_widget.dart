import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novoapp/core/ThemeBloc/theme_bloc.dart';
import 'package:novoapp/core/commonWidgets/errorWidgets/somethingWrongErrorWidget.dart';
import 'package:novoapp/core/route/onGenerateRoute.dart';
import 'package:novoapp/core/theme/app_colors.dart';
import 'package:novoapp/core/theme/theme.dart';
import 'package:novoapp/core/theme/themeprovider.dart';
import 'package:novoapp/features/novo/data/novo_data_source/models/sgbModel/sgb_InvestDetails_model.dart';
import 'package:novoapp/features/novo/presentation/cubit/Sgb_FetchData_Cubit/sgb_fetch_data_cubit.dart';
import 'package:novoapp/features/novo/presentation/widgets/custom_SearchBar.dart';
import 'package:novoapp/features/novo/presentation/widgets/custom_disclaimar_Footer.dart';
import 'package:provider/provider.dart';

class CustomInvestScreenListviewBuilder extends StatefulWidget {
  final String disclimar;
  final SGBinvestDetailsModel sgbMasterDetailsModel;
  final List<SgbDetail> sgbDetailList;
  final dynamic accountBalance;

  const CustomInvestScreenListviewBuilder(
      {Key? key,
      required this.disclimar,
      required this.sgbMasterDetailsModel,
      required this.sgbDetailList,
      required this.accountBalance})
      : super(key: key);

  @override
  _CustomInvestScreenListviewBuilderState createState() =>
      _CustomInvestScreenListviewBuilderState();
}

class _CustomInvestScreenListviewBuilderState
    extends State<CustomInvestScreenListviewBuilder> {
  late List<SgbDetail> filterdatalist;
  String searchtext = "";

  @override
  void initState() {
    super.initState();
    // context.read<SgbFetchDataCubit>().getSGBData();
    filterdatalist = widget.sgbDetailList;
  }

  void searchdata(String value) {
    searchtext = value;
    setState(() {
      if (searchtext.isEmpty) {
        filterdatalist = widget.sgbDetailList;
      } else {
        filterdatalist = widget.sgbDetailList
            .where((data) => data.symbol
                .toString()
                .toLowerCase()
                .contains(searchtext.toLowerCase()))
            .toList();
      }
    });
  }

  buttonVisibleFunc(SgbDetail filterdataList) {
    if (filterdataList.buttonText.isNotEmpty &&
        filterdataList.buttonText != '' &&
        filterdataList.actionFlag != '' &&
        filterdataList.actionFlag.isNotEmpty) {
      return true;
    }

    return false;
  }

  buttonDisableFunc(SgbDetail filterdataList) {
    if (!(filterdataList.actionFlag == 'U' ||
            filterdataList.actionFlag == 'P' ||
            filterdataList.actionFlag == 'B' ||
            filterdataList.actionFlag == 'M' ||
            filterdataList.actionFlag == 'A' ||
            filterdataList.actionFlag == 'C') ||
        filterdataList.disableActionBtn == true) {
      return true;
    }
    return false;
  }

  buttonColorFunc(SgbDetail filterdataList) {
    if ((filterdataList.actionFlag == 'P' ||
            filterdataList.actionFlag == 'B') &&
        filterdataList.disableActionBtn == false) {
      return appPrimeColor;
    } else if ((filterdataList.actionFlag == 'M' ||
            filterdataList.actionFlag == 'A' ||
            filterdataList.actionFlag == 'U' ||
            filterdataList.actionFlag == 'C') &&
        filterdataList.disableActionBtn == false) {
      return modifyButtonColor;
    } else if (filterdataList.disableActionBtn == false) {
      return appPrimeColor;
    }
  }

  onSubmit(SgbDetail sgbMasterDetails, dynamic accountBalance) {
    Navigator.pushNamed(context, PageConst.sgbPlaceOrderScreen, arguments: {
      'SgbDetails': sgbMasterDetails,
      'accountbalance': accountBalance
    });
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
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SearchFeild(
            visible: widget.sgbMasterDetailsModel.masterFound == 'Y' &&
                widget.sgbDetailList.isNotEmpty,
            onChange: searchdata,
          ),
          SizedBox(height: 5),
          widget.sgbMasterDetailsModel.masterFound == 'Y'
              ? filterdatalist.isEmpty
                  ? Expanded(
                      child: Center(
                        child: Text('Record Not Found'),
                      ),
                    )
                  : Expanded(
                      child: ListView.separated(
                        separatorBuilder: (context, index) {
                          return Divider(
                            color: darkTheme
                                ? Colors.white10
                                : const Color.fromRGBO(235, 237, 236, 1),
                            thickness: 1.5,
                          );
                        },
                        itemCount: filterdatalist.length + 1,
                        itemBuilder: (context, index) {
                          if (index < filterdatalist.length) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.65,
                                              child: Text(
                                                filterdatalist[index].symbol,
                                                style: darkTheme
                                                    ? ThemeClass.Darktheme
                                                        .textTheme.titleSmall
                                                    : ThemeClass.Lighttheme
                                                        .textTheme.titleSmall,
                                              ),
                                            ),
                                          ),
                                          FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.65,
                                              child: Text(
                                                filterdatalist[index].name,
                                                style: darkTheme
                                                    ? ThemeClass.Darktheme
                                                        .textTheme.displayMedium
                                                    : ThemeClass
                                                        .Lighttheme
                                                        .textTheme
                                                        .displayMedium,
                                              ),
                                            ),
                                          ),
                                          RichText(
                                            text: TextSpan(
                                              text: 'Unit Price  ',
                                              style: darkTheme
                                                  ? ThemeClass.Darktheme
                                                      .textTheme.displayMedium
                                                  : ThemeClass.Lighttheme
                                                      .textTheme.displayMedium,
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text:
                                                      '\u{20B9}${filterdatalist[index].unitPrice.toString()}',
                                                  style: darkTheme
                                                      ? ThemeClass.Darktheme
                                                          .textTheme.bodyMedium
                                                      : ThemeClass.Lighttheme
                                                          .textTheme.bodyMedium,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Visibility(
                                      visible: buttonVisibleFunc(
                                          filterdatalist[index]),
                                      child: SizedBox(
                                        width: 100,
                                        child: MaterialButton(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5),
                                          elevation: 2,
                                          disabledColor: Colors.grey,
                                          disabledTextColor: Colors.white70,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18),
                                          ),
                                          color: buttonColorFunc(
                                              filterdatalist[index]),
                                          onPressed: buttonDisableFunc(
                                                  filterdatalist[index])
                                              ? null
                                              : () {
                                                  onSubmit(
                                                      filterdatalist[index],
                                                      widget.accountBalance);
                                                },
                                          child: Text(
                                            filterdatalist[index].buttonText,
                                            maxLines: 1,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: filterdatalist[index]
                                                              .actionFlag ==
                                                          'M' &&
                                                      filterdatalist[index]
                                                              .disableActionBtn ==
                                                          false
                                                  ? appPrimeColor
                                                  : Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        text: 'Ordered Unit  ',
                                        style: darkTheme
                                            ? ThemeClass.Darktheme.textTheme
                                                .displayMedium
                                            : ThemeClass.Lighttheme.textTheme
                                                .displayMedium,
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: filterdatalist[index]
                                                .appliedUnit
                                                .toString(),
                                            style: darkTheme
                                                ? ThemeClass.Darktheme.textTheme
                                                    .bodyMedium
                                                : ThemeClass.Lighttheme
                                                    .textTheme.bodyMedium,
                                          ),
                                        ],
                                      ),
                                    ),
                                    FittedBox(
                                      child: Text(
                                        filterdatalist[index].dateRange,
                                        style: darkTheme
                                            ? ThemeClass
                                                .Darktheme.textTheme.bodySmall
                                            : ThemeClass
                                                .Lighttheme.textTheme.bodySmall,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            );
                          } else {
                            return Visibility(
                              visible: widget.disclimar.isNotEmpty &&
                                  (widget.sgbMasterDetailsModel.masterFound ==
                                          'Y' ||
                                      widget.sgbMasterDetailsModel
                                              .masterFound ==
                                          'N'),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  NovoFooterWidget(
                                    disclimerText: widget.disclimar,
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                      ),
                    )
              : widget.sgbMasterDetailsModel.masterFound == 'N' &&
                      widget.sgbMasterDetailsModel.masterFound.isNotEmpty &&
                      widget.sgbMasterDetailsModel.noDataText.isNotEmpty
                  ? Expanded(
                      child: Center(
                        child: Text(widget.sgbMasterDetailsModel.noDataText),
                      ),
                    )
                  : Expanded(child: SomethingWentWrongErrorPage()),
        ],
      ),
    );
  }
}
