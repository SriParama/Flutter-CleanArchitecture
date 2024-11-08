import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novoapp/core/ThemeBloc/theme_bloc.dart';
import 'package:novoapp/core/common/globleVariables.dart';
import 'package:novoapp/core/common/show_dialog.dart';
import 'package:novoapp/core/common/show_snackbar.dart';
import 'package:novoapp/core/commonWidgets/loadingAlartBox.dart';
import 'package:novoapp/core/theme/app_colors.dart';
import 'package:novoapp/core/theme/theme.dart';
import 'package:novoapp/core/theme/themeprovider.dart';
import 'package:novoapp/features/auth/presentation/blocs/auth_cookie_cubit/auth_cookie_cubit.dart';
import 'package:novoapp/features/novo/data/novo_data_source/models/sgbModel/sgb_InvestDetails_model.dart';
import 'package:novoapp/features/novo/domine/entity/sgbPlaceOrderEntity.dart';
import 'package:novoapp/features/novo/presentation/bloc/SGB_PlaceOrder_Bloc/post_sgb_order_bloc.dart';
import 'package:novoapp/features/novo/presentation/cubit/Sgb_FetchData_Cubit/sgb_fetch_data_cubit.dart';
import 'package:novoapp/features/novo/presentation/widgets/custom_InfoContainer.dart';
import 'package:provider/provider.dart';

class SGBplaceOrderScreen extends StatefulWidget {
  final SgbDetail sgbMasterDetails;
  final dynamic accountBalance;
  const SGBplaceOrderScreen(
      {super.key,
      required this.sgbMasterDetails,
      required this.accountBalance});

  @override
  State<SGBplaceOrderScreen> createState() => _SGBplaceOrderScreenState();
}

class _SGBplaceOrderScreenState extends State<SGBplaceOrderScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController quantityController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  double textHeight = 1.5;

  dynamic accountBalance = 0;
  bool isChecked = false;
  bool recheck = false;

  int totalAmount = 0;
  int totalDiscountAmount = 0;
  int amountPayable = 0;
  bool buttonDisable = true;
  @override
  void initState() {
    context.read<AuthCookieCubit>().loggedIn();
    intialationFunc();
    super.initState();
  }

  intialationFunc() {
    // getAccountBalanceAPI();
    priceController.text = widget.sgbMasterDetails.unitPrice.toString();
    quantityController.text = widget.sgbMasterDetails.actionFlag == 'M'
        ? widget.sgbMasterDetails.appliedUnit.toString()
        : widget.sgbMasterDetails.minBidQty.toString();
    totalAmount =
        int.parse(priceController.text) * int.parse(quantityController.text);
    accountBalance = widget.accountBalance ?? 'NA';
    totalDiscountAmount = int.parse(quantityController.text) *
        widget.sgbMasterDetails.discountAmt;
    amountPayable = totalAmount - totalDiscountAmount;
    // //////print(accountBalance);
    // widget.sgbMasterDetails.showSI = false;

    isChecked = widget.sgbMasterDetails.sIvalue!;
    if (widget.sgbMasterDetails.actionFlag == 'M' ||
        widget.sgbMasterDetails.actionFlag == 'A' ||
        widget.sgbMasterDetails.actionFlag == 'C') {
      setState(() {
        buttonDisable = true;
      });
    } else {
      setState(() {
        buttonDisable = false;
      });
    }
  }

  incrementUnitValue() {
    String currentValue = quantityController.text;
    int currentQuantity = int.tryParse(currentValue) ?? 0;
    if (currentQuantity < widget.sgbMasterDetails.maxBidQty) {
      quantityController.text = (currentQuantity + 1).toString();

      totalCalculation();
    }
  }

  decrementUnitValue() {
    String currentValue = quantityController.text;
    int currentQuantity = int.tryParse(currentValue) ?? 0;
    if (currentQuantity > widget.sgbMasterDetails.minBidQty) {
      quantityController.text = (currentQuantity - 1).toString();
      totalCalculation();
    }
  }

  totalCalculation() {
    setState(() {
      totalAmount = int.parse(
              quantityController.text == "" ? "0" : quantityController.text) *
          (int.parse(priceController.text));
      totalDiscountAmount = int.parse(
              quantityController.text == "" ? "0" : quantityController.text) *
          widget.sgbMasterDetails.discountAmt;
      amountPayable = totalAmount - totalDiscountAmount;
      modifyValidation();

      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {});
      });
    });
  }

  quantityOnChange(value) {
    quantityValidator(value);

    totalCalculation();
  }

  quantityValidator(value) {
    if (value.isEmpty || value == null) {
      return '';
    }
    if (int.parse(value) < widget.sgbMasterDetails.minBidQty ||
        int.parse(value) > widget.sgbMasterDetails.maxBidQty) {
      return '${widget.sgbMasterDetails.minBidQty}-${widget.sgbMasterDetails.maxBidQty}';
    }
    return null;
  }

  modifyValidation() {
    if (quantityController.text !=
            widget.sgbMasterDetails.appliedUnit.toString() &&
        quantityController.text != '0' &&
        quantityController.text.isNotEmpty) {
      buttonDisable = false;
    } else {
      buttonDisable = true;
    }
  }

  onSubmitPlaceOrder() {
    setState(() {
      recheck = true;
    });
    if (widget.sgbMasterDetails.showSI!) {
      if (isChecked) {
        try {
          if (widget.sgbMasterDetails.actionFlag == 'B' ||
              widget.sgbMasterDetails.actionFlag == 'P') {
            context.read<SgbOrderBloc>().add(PostSgbOrderEvent(
                    sgBplaceOrderEntity: SGBplaceOrderEntity(
                  masterId: widget.sgbMasterDetails.id,
                  bidId: "",
                  unit: int.parse(quantityController.text),
                  price: widget.sgbMasterDetails.unitPrice -
                      widget.sgbMasterDetails.discountAmt,
                  actionCode: 'N',
                  orderNo: "",
                  amount: amountPayable.toInt(),
                  oldUnit: 0,
                  SIvalue: isChecked,
                  SItext: widget.sgbMasterDetails.sItext,
                )));
          } else if (widget.sgbMasterDetails.actionFlag == 'M' ||
              widget.sgbMasterDetails.actionFlag == 'A') {
            context.read<SgbOrderBloc>().add(PostSgbOrderEvent(
                    sgBplaceOrderEntity: SGBplaceOrderEntity(
                  masterId: widget.sgbMasterDetails.id,
                  bidId: "",
                  unit: int.parse(quantityController.text),
                  price: widget.sgbMasterDetails.unitPrice -
                      widget.sgbMasterDetails.discountAmt,
                  actionCode: 'M',
                  orderNo: widget.sgbMasterDetails.orderNo,
                  amount: amountPayable.toInt(),
                  oldUnit: widget.sgbMasterDetails.appliedUnit,
                  SIvalue: isChecked,
                  SItext: widget.sgbMasterDetails.sItext,
                )));
          }
        } catch (e) {
          showSnackBar(context, somethingError, primaryRedColor);
        }
      } else {
        showSnackBar(
            context, "Agree to Terms and Place Order", primaryRedColor);
      }
    } else {
      try {
        if (widget.sgbMasterDetails.actionFlag == 'B' ||
            widget.sgbMasterDetails.actionFlag == 'P') {
          context.read<SgbOrderBloc>().add(PostSgbOrderEvent(
                  sgBplaceOrderEntity: SGBplaceOrderEntity(
                masterId: widget.sgbMasterDetails.id,
                bidId: "",
                unit: int.parse(quantityController.text),
                price: widget.sgbMasterDetails.unitPrice -
                    widget.sgbMasterDetails.discountAmt,
                actionCode: 'N',
                orderNo: "",
                amount: amountPayable.toInt(),
                oldUnit: 0,
                SIvalue: isChecked,
                SItext: widget.sgbMasterDetails.sItext,
              )));
        } else if (widget.sgbMasterDetails.actionFlag == 'M' ||
            widget.sgbMasterDetails.actionFlag == 'A') {
          context.read<SgbOrderBloc>().add(PostSgbOrderEvent(
                  sgBplaceOrderEntity: SGBplaceOrderEntity(
                masterId: widget.sgbMasterDetails.id,
                bidId: "",
                unit: int.parse(quantityController.text),
                price: widget.sgbMasterDetails.unitPrice -
                    widget.sgbMasterDetails.discountAmt,
                actionCode: 'M',
                orderNo: widget.sgbMasterDetails.orderNo,
                amount: amountPayable.toInt(),
                oldUnit: widget.sgbMasterDetails.appliedUnit,
                SIvalue: isChecked,
                SItext: widget.sgbMasterDetails.sItext,
              )));
        }
      } catch (e) {
        showSnackBar(context, somethingError, primaryRedColor);
      }
    }
  }

  deletePlaceOrder() {
    try {
      if (!_formKey.currentState!.validate()) {
        Navigator.pop(context);
        return;
      }
      context.read<SgbOrderBloc>().add(PostSgbOrderEvent(
              sgBplaceOrderEntity: SGBplaceOrderEntity(
            masterId: widget.sgbMasterDetails.id,
            bidId: "",
            unit: int.parse(quantityController.text),
            price: widget.sgbMasterDetails.unitPrice -
                widget.sgbMasterDetails.discountAmt,
            actionCode: 'D',
            orderNo: widget.sgbMasterDetails.orderNo,
            amount: amountPayable.toInt(),
            oldUnit: widget.sgbMasterDetails.appliedUnit,
            SIvalue: isChecked,
            SItext: widget.sgbMasterDetails.sItext,
          )));
      Navigator.pop(context);
    } catch (e) {
      showSnackBar(context, somethingError, primaryRedColor);
    }
  }

  @override
  Widget build(BuildContext context) {
    // final themeBloc = BlocProvider.of<ThemeBloc>(context);
    // final darkThemeMode = themeBloc.state.themeMode == ThemeMode.dark;
    // final lightThemeMode = themeBloc.state.themeMode == ThemeMode.light;
    // Color themeBasedColor =
    //     darkThemeMode ? titleTextColorDark : titleTextColorLight;
    return BlocConsumer<SgbOrderBloc, SgbOrderState>(
      builder: (context, state) {
        return _sbgPlaceOrderWidget();
      },
      listener: (context, state) {
        if (state is SgbOrderSuccess) {
          Navigator.pop(context);
          showSnackBar(context, state.message, primaryGreenColor);
          context.read<SgbFetchDataCubit>().getSGBData();
          Navigator.pop(context);
        } else if (state is SgbOrderFailure) {
          Navigator.pop(context);
          showSnackBar(context, state.error, primaryRedColor);
        } else if (state is SgbOrderLoading) {
          loadingAlertBox(context, 'Applying SGB...');
          // showSnackBar(context, 'loading', primaryOrangeColor);
        }
      },
    );
  }

  Widget _sbgPlaceOrderWidget() {
    // final themeBloc = BlocProvider.of<ThemeBloc>(context);
    // final darkThemeMode = themeBloc.state.themeMode == ThemeMode.dark;
    final darkThemeMode =
        Provider.of<NavigationProvider>(context).themeMode == ThemeMode.dark;
    final lightThemeMode =
        Provider.of<NavigationProvider>(context).themeMode == ThemeMode.light;
    Color themeBasedColor =
        darkThemeMode ? titleTextColorDark : titleTextColorLight;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness:
                darkThemeMode ? Brightness.light : Brightness.dark),
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              CupertinoIcons.arrow_left,
              size: 20.0,
              color: themeBasedColor,
            )),
        title: Text(widget.sgbMasterDetails.symbol,
            overflow: TextOverflow.visible,
            style: lightThemeMode
                ? ThemeClass.Lighttheme.textTheme.titleSmall
                : ThemeClass.Darktheme.textTheme.titleSmall),
        toolbarHeight: MediaQuery.of(context).size.height * 0.08,
        foregroundColor: darkThemeMode ? titleTextColorDark : Colors.black45,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20.0, bottom: 20.0, top: 5.0),
                  width: MediaQuery.of(context).size.width,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              darkThemeMode
                                  ? "assets/images/SGB WNovo Icon.png"
                                  : "assets/images/SGB BNovo Icon.png",
                              width: 34.0,
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Flexible(
                              child: Text(
                                widget.sgbMasterDetails.name,
                                overflow: TextOverflow.visible,
                                style: lightThemeMode
                                    ? ThemeClass
                                        .Lighttheme.textTheme.titleSmall!
                                        .copyWith(height: 1.8)
                                    : ThemeClass.Darktheme.textTheme.titleSmall,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // accountBalance is String
                                //     ? SizedBox()
                                //     :
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Current Ledger Balance',
                                      style: lightThemeMode
                                          ? ThemeClass
                                              .Lighttheme.textTheme.titleSmall!
                                              .copyWith(
                                              height: textHeight,
                                            )
                                          : ThemeClass
                                              .Darktheme.textTheme.titleSmall!
                                              .copyWith(
                                              height: textHeight,
                                            ),
                                    ),
                                    // acBalLoading
                                    //     ? SizedBox(
                                    //         height: 5,
                                    //         width: 35,
                                    //         child: LinearProgressIndicator(
                                    //           backgroundColor: inactiveColor,
                                    //           color: titleTextColorLight
                                    //               .withOpacity(0.3),
                                    //           borderRadius:
                                    //               BorderRadius.circular(10),
                                    //         ))
                                    //     :

                                    accountBalance is String
                                        ? Text('$accountBalance',
                                            style: ThemeClass.Lighttheme
                                                .textTheme.titleMedium!
                                                .copyWith(
                                              height: textHeight,
                                            ))
                                        : Text(
                                            // '₹ $accountBalance',

                                            rsFormat.format(accountBalance),
                                            style:
                                                //  lightThemeMode
                                                //     ?
                                                ThemeClass.Lighttheme.textTheme
                                                    .titleMedium!
                                                    .copyWith(
                                                        height: textHeight,
                                                        color: accountBalance >
                                                                0
                                                            ? primaryGreenColor
                                                            : primaryRedColor)
                                            // : ThemeClass.Darktheme
                                            //     .textTheme.titleMedium!
                                            //     .copyWith(
                                            //         height: textHeight,
                                            //         color: accountBalance >
                                            //                 0
                                            //             ? primaryGreenColor
                                            //             : primaryRedColor)
                                            ),
                                  ],
                                ),
                                Visibility(
                                  visible:
                                      widget.sgbMasterDetails.cancelAllowed!,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            customDialogBox(
                                                context,
                                                'Do you want to delete the SGB order?',
                                                deletePlaceOrder);
                                            // context.read<SgbOrderBloc>().add(
                                            //         DeleteSgbOrderEvent(
                                            //             sgBplaceOrderEntity:
                                            //                 SGBplaceOrderEntity(
                                            //       masterId: widget
                                            //           .sgbMasterDetails.id,
                                            //       bidId: "",
                                            //       unit: 2,
                                            //       price: 2900,
                                            //       actionCode: 'D',
                                            //       orderNo: widget
                                            //           .sgbMasterDetails.orderNo,
                                            //       amount: 5800,
                                            //       oldUnit: 0,
                                            //       SIvalue: true,
                                            //       SItext:
                                            //           "Place order to the extent of the available balance in my account in case of insufficient balance.",
                                            //     )));

                                            // deleteBidDialogBox(
                                            //   context,
                                            //   deleteLoading,
                                            //   () => deleteBidInAPI(),
                                            //   widget
                                            //       .sgbMasterDetails.sIrefundText,
                                            // );
                                          },
                                          child: Icon(
                                            Icons.delete,
                                            color: primaryRedColor,
                                          )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            Text(
                              'Unit Price',
                              style:
                                  ThemeClass.Lighttheme.textTheme.displayMedium,
                            ),
                            Text(
                              rsMrkFormat
                                  .format(widget.sgbMasterDetails.unitPrice),
                              style: lightThemeMode
                                  ? ThemeClass.Lighttheme.textTheme.titleSmall!
                                      .copyWith(
                                      height: textHeight,
                                    )
                                  : ThemeClass.Darktheme.textTheme.titleSmall!
                                      .copyWith(
                                      height: textHeight,
                                    ),
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            Text(
                              widget.sgbMasterDetails.discountText,
                              style:
                                  ThemeClass.Lighttheme.textTheme.displayMedium,
                            ),
                            Text(
                              widget.sgbMasterDetails.discountAmt == 0
                                  ? 'N/A'
                                  : rsMrkFormat.format(
                                      widget.sgbMasterDetails.discountAmt),
                              style: lightThemeMode
                                  ? ThemeClass.Lighttheme.textTheme.titleSmall!
                                      .copyWith(
                                      height: textHeight,
                                    )
                                  : ThemeClass.Darktheme.textTheme.titleSmall!
                                      .copyWith(
                                      height: textHeight,
                                    ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Visibility(
                          visible: widget.sgbMasterDetails.infoText.isNotEmpty,
                          child: InfoContainer(
                            infoMsg: widget.sgbMasterDetails.infoText,
                          ),
                        ),
                        SizedBox(
                          height: 25.0,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              border: Border.all(
                                  color: darkThemeMode
                                      ? Colors.grey
                                      : const Color.fromRGBO(235, 237, 236, 1)),
                              boxShadow: [
                                BoxShadow(
                                  color: darkThemeMode
                                      ? Colors.transparent
                                      : Colors.grey.shade200,
                                  offset: const Offset(0,
                                      1.0), // Offset (x, y) controls the shadow's position
                                  blurRadius: 15, // Spread of the shadow
                                  spreadRadius:
                                      5.0, // Positive values expand the shadow, negative values shrink it
                                ),
                              ],
                              color: lightThemeMode
                                  ? titleTextColorDark
                                  : Colors.transparent),
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Bidding Starts: ',
                                style: ThemeClass
                                    .Lighttheme.textTheme.displayMedium,
                              ),
                              Text(widget.sgbMasterDetails.startDateWithTime,
                                  textAlign: TextAlign.end,
                                  softWrap: true,
                                  maxLines: 2,
                                  overflow: TextOverflow.visible,
                                  style: lightThemeMode
                                      ? ThemeClass
                                          .Lighttheme.textTheme.titleSmall!
                                          .copyWith(
                                          height: textHeight,
                                        )
                                      : ThemeClass
                                          .Darktheme.textTheme.titleSmall!
                                          .copyWith(
                                          height: textHeight,
                                        )),
                              SizedBox(
                                height: 15.0,
                              ),
                              Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: const Color.fromRGBO(
                                          235, 237, 236, 1),
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextFormField(
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          textAlign: TextAlign.center,
                                          keyboardType: TextInputType.number,
                                          style: darkThemeMode
                                              ? ThemeClass.Darktheme.textTheme
                                                  .titleSmall
                                              : ThemeClass.Lighttheme.textTheme
                                                  .titleSmall,
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(
                                                RegExp(r'[0-9]'))
                                          ],
                                          enabled: widget
                                              .sgbMasterDetails.modifyAllowed,
                                          controller: quantityController,
                                          maxLength: 4,
                                          validator: (value) =>
                                              quantityValidator(value),
                                          onChanged: (value) {
                                            quantityOnChange(value);
                                          },
                                          decoration: InputDecoration(
                                            disabledBorder:
                                                UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: const Color
                                                            .fromRGBO(
                                                            235, 237, 236, 1),
                                                        width: 2.0)),
                                            // isDense: true,
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: const Color.fromRGBO(
                                                        235, 237, 236, 1),
                                                    width: 2.0)),
                                            focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: primaryGreenColor,
                                                    width: 0.4)),
                                            counterText: '',
                                            labelText: 'Unit to buy',
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.always,
                                            hintText: '0',
                                            labelStyle: ThemeClass.Lighttheme
                                                .textTheme.displayMedium!
                                                .copyWith(fontSize: 18),
                                            errorBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: primaryRedColor
                                                        .withOpacity(1),
                                                    width: 2)),
                                            contentPadding: EdgeInsets.zero,

                                            prefix: Visibility(
                                              visible: widget.sgbMasterDetails
                                                  .modifyAllowed!,
                                              child: InkWell(
                                                onTap: () =>
                                                    decrementUnitValue(),
                                                child: Transform.scale(
                                                  scale: 1.3,
                                                  child: Text(
                                                    '-',
                                                    style: TextStyle(
                                                      fontFamily: 'inter',
                                                      color:
                                                          //  widget.sgbMasterDetails
                                                          //                 .minBidQty >=
                                                          //             int.parse(
                                                          //                 quantityController
                                                          //                     .text) &&
                                                          //         quantityController
                                                          //             .text
                                                          //             .isNotEmpty
                                                          //     ? subTitleTextColor
                                                          //         .withOpacity(0.3)
                                                          //     :
                                                          subTitleTextColor,
                                                      fontSize: 24,
                                                      height: 0.9,
                                                      letterSpacing: 18,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            suffix: InkWell(
                                              onTap: () {
                                                incrementUnitValue();
                                              },
                                              child: Visibility(
                                                visible: widget.sgbMasterDetails
                                                    .modifyAllowed!,
                                                child: Text(
                                                  '+',
                                                  style: TextStyle(
                                                    fontFamily: 'inter',
                                                    color: subTitleTextColor,
                                                    fontSize: 25,
                                                    height: 1,
                                                    letterSpacing: 16,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8.0,
                                        ),
                                      ],
                                    ),
                                  )),
                              SizedBox(
                                height: 40.0,
                              ),
                              Text(
                                'Bidding Ends: ',
                                style: ThemeClass
                                    .Lighttheme.textTheme.displayMedium,
                              ),
                              Text(
                                widget.sgbMasterDetails.endDateWithTime,
                                textAlign: TextAlign.end,
                                softWrap: true,
                                maxLines: 2,
                                overflow: TextOverflow.visible,
                                style: lightThemeMode
                                    ? ThemeClass
                                        .Lighttheme.textTheme.titleSmall!
                                        .copyWith(
                                        height: textHeight,
                                      )
                                    : ThemeClass.Darktheme.textTheme.titleSmall!
                                        .copyWith(
                                        height: textHeight,
                                      ),
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              Text(
                                'ISIN: ',
                                style: ThemeClass
                                    .Lighttheme.textTheme.displayMedium,
                              ),
                              Text(
                                widget.sgbMasterDetails.isin,
                                style: lightThemeMode
                                    ? ThemeClass
                                        .Lighttheme.textTheme.titleSmall!
                                        .copyWith(
                                        height: textHeight,
                                      )
                                    : ThemeClass.Darktheme.textTheme.titleSmall!
                                        .copyWith(
                                        height: textHeight,
                                      ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Visibility(
                          visible: widget.sgbMasterDetails.showSI!,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isChecked = !isChecked;
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 18,
                                  height: 18,
                                  margin: EdgeInsets.only(top: 4.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        5.0), // Set the radius to 2.0
                                    color: isChecked
                                        ? appPrimeColor
                                        : Colors.transparent,
                                    border: Border.all(
                                      color: !isChecked && recheck
                                          ? primaryRedColor
                                          : subTitleTextColor,
                                      width: 2,
                                    ),
                                  ),
                                  child: isChecked
                                      ? const Icon(
                                          CupertinoIcons.checkmark_alt,
                                          color: Colors.white,
                                          size: 12,
                                        )
                                      : null,
                                ),
                                SizedBox(
                                  width: 12.0,
                                ),
                                Expanded(
                                  child: Text(
                                    widget.sgbMasterDetails.sItext,
                                    style: ThemeClass
                                        .Lighttheme.textTheme.displayMedium,
                                    textAlign: TextAlign.justify,
                                    overflow: TextOverflow
                                        .visible, // Set the overflow behavior
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            color: darkThemeMode
                ? Color.fromRGBO(48, 48, 48, 1)
                : Color.fromRGBO(240, 240, 240, 1),
            child: Column(
              children: [
                /*Total Amount Section...*/
                Container(
                  // height: 40.0,
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                  // width: double.infinity,
                  color: darkThemeMode
                      ? Colors.grey.shade400
                      : Colors.grey.shade400,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Amount payable',
                            style: TextStyle(
                                fontFamily: 'inter',
                                color: darkThemeMode
                                    ? Colors.black
                                    : titleTextColorLight,
                                fontSize: 14.0,
                                height: 1.0,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            rsFormat.format(amountPayable),
                            style: TextStyle(
                                fontFamily: 'inter',
                                color: amountPayable == 0
                                    ? titleTextColorLight
                                    : primaryGreenColor,
                                height: 1.0,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                MaterialButton(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    padding: EdgeInsets.zero,
                    disabledColor: Colors.grey,
                    minWidth: MediaQuery.of(context).size.width,
                    height: 45,
                    color: appPrimeColor,
                    onPressed: buttonDisable
                        ? null
                        : () {
                            onSubmitPlaceOrder();
                          },
                    child: Text(
                      widget.sgbMasterDetails.buttonText,
                      style: TextStyle(
                        color:
                            // submitLoading || buttonDisable
                            //     ? Colors.white.withOpacity(0.20)
                            //     :
                            Colors.white,
                        fontSize: 18.0,
                        fontFamily: 'inter',
                        fontWeight: FontWeight.w700,
                        height: 1.04,
                      ),
                    )),
              ],
            ),
          )
        ],
      )),
    );
  }
}

// Scaffold(
//       resizeToAvoidBottomInset: true,
//       appBar: AppBar(
//         systemOverlayStyle: SystemUiOverlayStyle(
//             statusBarColor: Colors.transparent,
//             statusBarIconBrightness:
//                 darkThemeMode ? Brightness.light : Brightness.dark),
//         leading: IconButton(
//             onPressed: () => Navigator.of(context).pop(),
//             icon: Icon(
//               CupertinoIcons.arrow_left,
//               size: 20.0,
//               color: themeBasedColor,
//             )),
//         title: Text(widget.sgbMasterDetails.symbol,
//             overflow: TextOverflow.visible,
//             style: lightThemeMode
//                 ? ThemeClass.Lighttheme.textTheme.titleSmall
//                 : ThemeClass.Darktheme.textTheme.titleSmall),
//         toolbarHeight: MediaQuery.of(context).size.height * 0.08,
//         foregroundColor: darkThemeMode ? titleTextColorDark : Colors.black45,
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//       ),
//       body:

//       SafeArea(
//           child: Stack(
//         children: [
//           ListView(
//             children: [
//               Container(
//                 padding: const EdgeInsets.only(
//                     left: 20.0, right: 20.0, bottom: 20.0, top: 5.0),
//                 width: MediaQuery.of(context).size.width,
//                 child: Form(
//                   key: _formKey,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Image.asset(
//                             Provider.of<NavigationProvider>(context)
//                                         .themeMode ==
//                                     ThemeMode.dark
//                                 ? "assets/SGB WNovo Icon.png"
//                                 : "assets/SGB BNovo Icon.png",
//                             width: 34.0,
//                           ),
//                           const SizedBox(
//                             width: 10.0,
//                           ),
//                           Flexible(
//                             child: Text(
//                               widget.sgbMasterDetails.name,
//                               overflow: TextOverflow.visible,
//                               style: lightThemeMode
//                                   ? ThemeClass.Lighttheme.textTheme.titleSmall
//                                   : ThemeClass.Darktheme.textTheme.titleSmall,
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 10.0,
//                       ),
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               // accountBalance is String
//                               //     ? SizedBox()
//                               //     :
//                               Column(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     'Current Ledger Balance',
//                                     style: lightThemeMode
//                                         ? ThemeClass
//                                             .lighttheme.textTheme.titleSmall!
//                                             .copyWith(
//                                             height: textHeight,
//                                           )
//                                         : ThemeClass
//                                             .Darktheme.textTheme.titleSmall!
//                                             .copyWith(
//                                             height: textHeight,
//                                           ),
//                                   ),
//                                   acBalLoading
//                                       ? SizedBox(
//                                           height: 5,
//                                           width: 35,
//                                           child: LinearProgressIndicator(
//                                             backgroundColor: inactiveColor,
//                                             color: titleTextColorLight
//                                                 .withOpacity(0.3),
//                                             borderRadius:
//                                                 BorderRadius.circular(10),
//                                           ))
//                                       : accountBalance is String
//                                           ? Text('$accountBalance',
//                                               style: ThemeClass.Lighttheme
//                                                   .textTheme.titleSmall!
//                                                   .copyWith(
//                                                 height: textHeight,
//                                               ))
//                                           : Text(
//                                               // '₹ $accountBalance',

//                                               rsFormat.format(accountBalance),
//                                               style:
//                                                   //  lightThemeMode
//                                                   //     ?
//                                                   ThemeClass.Lighttheme
//                                                       .textTheme.titleSmall!
//                                                       .copyWith(
//                                                           height: textHeight,
//                                                           color: accountBalance >
//                                                                   0
//                                                               ? primaryGreenColor
//                                                               : primaryRedColor)
//                                               // : ThemeClass.Darktheme
//                                               //     .textTheme.titleSmall!
//                                               //     .copyWith(
//                                               //         height: textHeight,
//                                               //         color: accountBalance >
//                                               //                 0
//                                               //             ? primaryGreenColor
//                                               //             : primaryRedColor)
//                                               ),
//                                 ],
//                               ),
//                               Visibility(
//                                 visible: widget.sgbMasterDetails.cancelAllowed!,
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.end,
//                                   children: [
//                                     InkWell(
//                                         onTap: () {
//                                           deleteBidDialogBox(
//                                             context,
//                                             deleteLoading,
//                                             () => deleteBidInAPI(),
//                                             widget
//                                                 .sgbMasterDetails.sIrefundText,
//                                           );
//                                         },
//                                         child: Icon(
//                                           Icons.delete,
//                                           color: primaryRedColor,
//                                         )),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(
//                             height: 8.0,
//                           ),
//                           Text(
//                             'Unit Price',
//                             style:
//                                 ThemeClass.Lighttheme.textTheme.displayMedium,
//                           ),
//                           Text(
//                             rsMrkFormat
//                                 .format(widget.sgbMasterDetails.unitPrice),
//                             style: lightThemeMode
//                                 ? ThemeClass.Lighttheme.textTheme.titleSmall!
//                                     .copyWith(
//                                     height: textHeight,
//                                   )
//                                 : ThemeClass.Darktheme.textTheme.titleSmall!
//                                     .copyWith(
//                                     height: textHeight,
//                                   ),
//                           ),
//                           SizedBox(
//                             height: 8.0,
//                           ),
//                           Text(
//                             widget.sgbMasterDetails.discountText,
//                             style:
//                                 ThemeClass.Lighttheme.textTheme.displayMedium,
//                           ),
//                           Text(
//                             widget.sgbMasterDetails.discountAmt == 0
//                                 ? 'N/A'
//                                 : rsMrkFormat.format(
//                                     widget.sgbMasterDetails.discountAmt),
//                             style: lightThemeMode
//                                 ? ThemeClass.Lighttheme.textTheme.titleSmall!
//                                     .copyWith(
//                                     height: textHeight,
//                                   )
//                                 : ThemeClass.Darktheme.textTheme.titleSmall!
//                                     .copyWith(
//                                     height: textHeight,
//                                   ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 5.0,
//                       ),
//                       Visibility(
//                         visible: widget.sgbMasterDetails.infoText.isNotEmpty,
//                         child: InfoContainer(
//                           infoMsg: widget.sgbMasterDetails.infoText,
//                         ),
//                       ),
//                       SizedBox(
//                         height: 25.0,
//                       ),
//                       Container(
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(20.0),
//                             border: Border.all(
//                                 color: darkThemeMode
//                                     ? Colors.grey
//                                     : const Color.fromRGBO(235, 237, 236, 1)),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: darkThemeMode
//                                     ? Colors.transparent
//                                     : Colors.grey.shade200,
//                                 offset: const Offset(0,
//                                     1.0), // Offset (x, y) controls the shadow's position
//                                 blurRadius: 15, // Spread of the shadow
//                                 spreadRadius:
//                                     5.0, // Positive values expand the shadow, negative values shrink it
//                               ),
//                             ],
//                             color: lightThemeMode
//                                 ? titleTextColorDark
//                                 : Colors.transparent),
//                         width: MediaQuery.of(context).size.width,
//                         padding: EdgeInsets.all(20.0),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Bidding Starts: ',
//                               style:
//                                   ThemeClass.Lighttheme.textTheme.displayMedium,
//                             ),
//                             Text(widget.sgbMasterDetails.startDateWithTime,
//                                 textAlign: TextAlign.end,
//                                 softWrap: true,
//                                 maxLines: 2,
//                                 overflow: TextOverflow.visible,
//                                 style: lightThemeMode
//                                     ? ThemeClass
//                                         .lighttheme.textTheme.titleSmall!
//                                         .copyWith(
//                                         height: textHeight,
//                                       )
//                                     : ThemeClass
//                                         .Darktheme.textTheme.titleSmall!
//                                         .copyWith(
//                                         height: textHeight,
//                                       )),
//                             SizedBox(
//                               height: 15.0,
//                             ),
//                             Container(
//                                 decoration: BoxDecoration(
//                                   border: Border.all(
//                                     color:
//                                         const Color.fromRGBO(235, 237, 236, 1),
//                                   ),
//                                   borderRadius: BorderRadius.circular(10.0),
//                                 ),
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(15.0),
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       TextFormField(
//                                         autovalidateMode:
//                                             AutovalidateMode.onUserInteraction,
//                                         textAlign: TextAlign.center,
//                                         keyboardType: TextInputType.number,
//                                         // enabled: unitenable,
//                                         style: TextStyle(
//                                           fontFamily: 'inter',
//                                           fontSize: subTitleFontSize,
//                                           // color: titleTextColorLight,
//                                         ),
//                                         inputFormatters: [
//                                           FilteringTextInputFormatter.allow(
//                                               RegExp(r'[0-9]'))
//                                         ],
//                                         enabled: widget
//                                             .sgbMasterDetails.modifyAllowed,
//                                         controller: quantityController,
//                                         maxLength: 4,
//                                         validator: (value) =>
//                                             quantityValidator(value),
//                                         onChanged: (value) {
//                                           quantityOnChange(value);
//                                         },

//                                         decoration: InputDecoration(
//                                           disabledBorder: UnderlineInputBorder(
//                                               borderSide: BorderSide(
//                                                   color: const Color.fromRGBO(
//                                                       235, 237, 236, 1),
//                                                   width: 2.0)),
//                                           // isDense: true,
//                                           enabledBorder: UnderlineInputBorder(
//                                               borderSide: BorderSide(
//                                                   color: const Color.fromRGBO(
//                                                       235, 237, 236, 1),
//                                                   width: 2.0)),
//                                           focusedBorder: UnderlineInputBorder(
//                                               borderSide: BorderSide(
//                                                   color: primaryGreenColor,
//                                                   width: 0.4)),
//                                           counterText: '',
//                                           labelText: 'Unit to buy',
//                                           floatingLabelBehavior:
//                                               FloatingLabelBehavior.always,
//                                           hintText: '0',
//                                           labelStyle: ThemeClass.Lighttheme
//                                               .textTheme.displayMedium!
//                                               .copyWith(fontSize: 18),
//                                           errorBorder: UnderlineInputBorder(
//                                               borderSide: BorderSide(
//                                                   color: primaryRedColor
//                                                       .withOpacity(1),
//                                                   width: 2)),
//                                           contentPadding: EdgeInsets.zero,

//                                           prefix: Visibility(
//                                             visible: widget.sgbMasterDetails
//                                                 .modifyAllowed!,
//                                             child: InkWell(
//                                               onTap: () => decrementUnitValue(),
//                                               child: Transform.scale(
//                                                 scale: 1.3,
//                                                 child: Text(
//                                                   '-',
//                                                   style: TextStyle(
//                                                     fontFamily: 'inter',
//                                                     color: subTitleTextColor,
//                                                     fontSize: 24,
//                                                     height: 0.9,
//                                                     letterSpacing: 18,
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                           suffix: InkWell(
//                                             onTap: () {
//                                               incrementUnitValue();
//                                             },
//                                             child: Visibility(
//                                               visible: widget.sgbMasterDetails
//                                                   .modifyAllowed!,
//                                               child: Text(
//                                                 '+',
//                                                 style: TextStyle(
//                                                   fontFamily: 'inter',
//                                                   color: subTitleTextColor,
//                                                   fontSize: 25,
//                                                   height: 1,
//                                                   letterSpacing: 16,
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       const SizedBox(
//                                         height: 8.0,
//                                       ),
//                                     ],
//                                   ),
//                                 )),
//                             SizedBox(
//                               height: 40.0,
//                             ),
//                             Text(
//                               'Bidding Ends: ',
//                               style:
//                                   ThemeClass.Lighttheme.textTheme.displayMedium,
//                             ),
//                             Text(
//                               widget.sgbMasterDetails.endDateWithTime,
//                               textAlign: TextAlign.end,
//                               softWrap: true,
//                               maxLines: 2,
//                               overflow: TextOverflow.visible,
//                               style: lightThemeMode
//                                   ? ThemeClass.Lighttheme.textTheme.titleSmall!
//                                       .copyWith(
//                                       height: textHeight,
//                                     )
//                                   : ThemeClass.Darktheme.textTheme.titleSmall!
//                                       .copyWith(
//                                       height: textHeight,
//                                     ),
//                             ),
//                             SizedBox(
//                               height: 15.0,
//                             ),
//                             Text(
//                               'ISIN: ',
//                               style:
//                                   ThemeClass.Lighttheme.textTheme.displayMedium,
//                             ),
//                             Text(
//                               widget.sgbMasterDetails.isin,
//                               style: lightThemeMode
//                                   ? ThemeClass.Lighttheme.textTheme.titleSmall!
//                                       .copyWith(
//                                       height: textHeight,
//                                     )
//                                   : ThemeClass.Darktheme.textTheme.titleSmall!
//                                       .copyWith(
//                                       height: textHeight,
//                                     ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(
//                         height: 20.0,
//                       ),
//                       Visibility(
//                         visible: widget.sgbMasterDetails.showSI!,
//                         child: GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               isChecked = !isChecked;
//                             });
//                           },
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Container(
//                                 width: 18,
//                                 height: 18,
//                                 margin: EdgeInsets.only(top: 4.0),
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(
//                                       5.0), // Set the radius to 2.0
//                                   color: isChecked
//                                       ? appPrimeColor
//                                       : Colors.transparent,
//                                   border: Border.all(
//                                     color: !isChecked && recheck
//                                         ? primaryRedColor
//                                         : subTitleTextColor,
//                                     width: 2,
//                                   ),
//                                 ),
//                                 child: isChecked
//                                     ? const Icon(
//                                         CupertinoIcons.checkmark_alt,
//                                         color: Colors.white,
//                                         size: 12,
//                                       )
//                                     : null,
//                               ),
//                               SizedBox(
//                                 width: 12.0,
//                               ),
//                               Expanded(
//                                 child: Text(
//                                   widget.sgbMasterDetails.sItext,
//                                   style: ThemeClass
//                                       .lighttheme.textTheme.displayMedium,
//                                   textAlign: TextAlign.justify,
//                                   overflow: TextOverflow
//                                       .visible, // Set the overflow behavior
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 150,
//               ),
//             ],
//           ),
//           Positioned(
//               bottom: 0,
//               left: 0,
//               child: Container(
//                 width: MediaQuery.of(context).size.width,
//                 color: Provider.of<NavigationProvider>(context).themeMode ==
//                         ThemeMode.dark
//                     ? Color.fromRGBO(48, 48, 48, 1)
//                     : Color.fromRGBO(240, 240, 240, 1),
//                 child: Column(
//                   children: [
//                     /*Total Amount Section...*/
//                     Container(
//                       // height: 40.0,
//                       padding: EdgeInsets.symmetric(
//                           horizontal: 10.0, vertical: 10.0),
//                       // width: double.infinity,
//                       color:
//                           Provider.of<NavigationProvider>(context).themeMode ==
//                                   ThemeMode.dark
//                               ? Colors.grey.shade400
//                               : Colors.grey.shade400,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Amount payable',
//                                 style: TextStyle(
//                                     fontFamily: 'inter',
//                                     color:
//                                         Provider.of<NavigationProvider>(context)
//                                                     .themeMode ==
//                                                 ThemeMode.dark
//                                             ? Colors.black
//                                             : titleTextColorLight,
//                                     fontSize: 14.0,
//                                     height: 1.0,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                               Text(
//                                 rsFormat.format(amountPayable),
//                                 style: TextStyle(
//                                     fontFamily: 'inter',
//                                     color: amountPayable == 0
//                                         ? titleTextColorLight
//                                         : primaryGreenColor,
//                                     height: 1.0,
//                                     fontSize: 16.0,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                     MaterialButton(
//                         materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                         padding: EdgeInsets.zero,
//                         disabledColor: Colors.grey,
//                         minWidth: MediaQuery.of(context).size.width,
//                         height: 45,
//                         color: appPrimeColor,
//                         onPressed: submitLoading || buttonDisable
//                             ? null
//                             : () {
//                                 sIShowCheckFunc();
//                               },
//                         child: Text(
//                           widget.sgbMasterDetails.buttonText,
//                           style: TextStyle(
//                             color: submitLoading || buttonDisable
//                                 ? Colors.white.withOpacity(0.20)
//                                 : Colors.white,
//                             fontSize: 18.0,
//                             fontFamily: 'inter',
//                             fontWeight: FontWeight.w700,
//                             height: 1.04,
//                           ),
//                         )),
//                   ],
//                 ),
//               ))
//         ],
//       )),
//     );
