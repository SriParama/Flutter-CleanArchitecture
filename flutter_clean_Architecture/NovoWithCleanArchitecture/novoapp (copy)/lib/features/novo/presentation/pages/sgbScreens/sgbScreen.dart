import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novoapp/core/ThemeBloc/theme_bloc.dart';
import 'package:novoapp/core/common/show_snackbar.dart';
import 'package:novoapp/core/commonWidgets/errorWidgets/somethingWrongErrorWidget.dart';
import 'package:novoapp/core/cubits/internet_cubit/internet_cubit.dart';
import 'package:novoapp/core/theme/app_colors.dart';
import 'package:novoapp/features/auth/presentation/blocs/auth_cookie_cubit/auth_cookie_cubit.dart';
import 'package:novoapp/features/novo/data/novo_data_source/models/sgbModel/sgb_InvestDetails_model.dart';
import 'package:novoapp/features/novo/data/novo_data_source/models/sgbModel/sgb_OrderDetails_model.dart';
import 'package:novoapp/features/novo/presentation/cubit/Sgb_FetchData_Cubit/sgb_fetch_data_cubit.dart';
import 'package:novoapp/features/novo/presentation/widgets/customTabBar_widget.dart';
import 'package:novoapp/features/novo/presentation/widgets/sgb_customWidget/custom_InvestScreen_listview_widget.dart';
import 'package:novoapp/features/novo/presentation/widgets/sgb_customWidget/custom_orderScreen_widget.dart';

class SgbScreen extends StatefulWidget {
  const SgbScreen({super.key});

  @override
  State<SgbScreen> createState() => _SgbScreenState();
}

class _SgbScreenState extends State<SgbScreen>
    with SingleTickerProviderStateMixin {
  String discliamer = '';
  SGBinvestDetailsModel? sgbMasterDetailsModel;
  List<SgbDetail>? sgbDetailsList;
  dynamic accountBalance;

  SGBorderDetialsModel? sgbOrderDetialsModel;
  List<SgbOrderHistoryArr>? sgbOrderDetailsList;

  late TabController _tabController;
  @override
  void initState() {
    context.read<AuthCookieCubit>().loggedIn();
    // context.read<SgbFetchDataCubit>().getSGBData();

    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SgbFetchDataCubit, SgbFetchDataState>(
      builder: (context, state) {
        if (state is SGBinvestDataLoaded) {
          discliamer = state.sgbInvestDetailsModel.disclaimer;
          sgbMasterDetailsModel = state.sgbInvestDetailsModel;
          sgbDetailsList = state.sgbInvestDetailsModel.sgbDetail;
          accountBalance = state.sgbFetchFund;

          return CustomTabBarWidget(
            tabController: _tabController,
            tabname1: 'Invest',
            tabname2: 'Order',
            titleText: 'Sovereign Gold Bond',
            titleDarkImage: "assets/images/SGB WNovo Icon.png",
            titleLightImage: "assets/images/SGB BNovo Icon.png",
            investScreenTabView: CustomInvestScreenListviewBuilder(
              disclimar: discliamer,
              sgbMasterDetailsModel: sgbMasterDetailsModel!,
              sgbDetailList: sgbDetailsList!,
              accountBalance: accountBalance ?? 'NA',
            ),
            // orderScreenTabView: CustomOrderScreenWidget(
            //   sgbOrderDetialsModel: sgbOrderDetialsModel!,
            //   sgbOrderDetailList: sgbOrderDetailsList!,
            // ),
          );
        } else if (state is SGBorderDataLoaded) {
          discliamer = state.sgbInvestDetailsModel.disclaimer;
          sgbMasterDetailsModel = state.sgbInvestDetailsModel;
          sgbDetailsList = state.sgbInvestDetailsModel.sgbDetail;
          sgbOrderDetialsModel = state.sgbOrderDetialsModel;
          sgbOrderDetailsList = state.sgbOrderDetialsModel.sgbOrderHistoryArr;
          return CustomTabBarWidget(
            tabController: _tabController,
            tabname1: 'Invest',
            tabname2: 'Order',
            titleText: 'Sovereign Gold Bond',
            titleDarkImage: "assets/images/SGB WNovo Icon.png",
            titleLightImage: "assets/images/SGB BNovo Icon.png",
            investScreenTabView: CustomInvestScreenListviewBuilder(
              disclimar: discliamer,
              sgbMasterDetailsModel: sgbMasterDetailsModel!,
              sgbDetailList: sgbDetailsList!,
              accountBalance: accountBalance,
            ),
            orderScreenTabView: CustomOrderScreenWidget(
              sgbOrderDetialsModel: sgbOrderDetialsModel!,
              sgbOrderDetailList: sgbOrderDetailsList!,
            ),
          );
        } else if (state is SGBinvestDataFailure) {
          print('something sgb invest problem');
          return SomethingWentWrongErrorPage();
        } else if (state is SGBorderDataFailure) {
          print('something sgb order problem');
          return SomethingWentWrongErrorPage();
        }
        // else if (state is SgbFetchDataInitial) {
        //   // discliamer = '';
        //   return Center(
        //     child: CircularProgressIndicator(),
        //   );
        // }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
