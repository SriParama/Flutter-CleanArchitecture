import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novo_clean_arch/features/domin/entities/dash_board_entity.dart';
import 'package:novo_clean_arch/features/presentation/cubit/fetchData/cubit/fetch_cubit.dart';

import '../cubit/auth/cubit/auth_cubit.dart';
import '../utils/colors.dart';

class HomePage extends StatefulWidget {
  final String cookie;
  const HomePage({super.key, required this.cookie});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FetchCubit, FetchState>(
        builder: (context, fetchState) {
          print("fetchState");
          print(fetchState);
          if (fetchState is FetchLoaded) {
            print('hi');

            List<SegmentArr> dashboardData =
                fetchState.dashboardData.segmentArr!;
            // print(dashboardData[0].name);
            print("fetchState.clientId");
            String clientId = fetchState.clientId;
            print(clientId);

            // print(fetchState.runtimeType);
            return _dashBoardWidget(dashboardData, clientId);
            // Column(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     // Center(
            //     //   child: Text(widget.cookie),
            //     // ),
            //     _dashBoardWidget(dashboardData),
            //     ElevatedButton(
            //         onPressed: () {
            //           BlocProvider.of<AuthCubit>(context).loggedOut();
            //         },
            //         child: Text('Logout'))
            //   ],
            // );
          } else {
            print('bye');
            return Center(
              child: CircularProgressIndicator(
                color: greenColor,
              ),
            );
          }
        },
      ),
    );
  }

  _dashBoardWidget(List<SegmentArr> dashboardData, String clientId) {
    return SafeArea(
      child: Column(
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
                ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<AuthCubit>(context).loggedOut();
                    },
                    child: Text('Logout')),
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
                                    dashboardData[index].path == '/ipo'
                                        ? 1
                                        : dashboardData[index].path == '/sgb'
                                            ? 2
                                            : dashboardData[index].path ==
                                                    '/gsec'
                                                ? 3
                                                : 0;
                                  }
                                : null,
                            child: Visibility(
                              visible: dashboardData[index].status == 'Y',
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          Colors.grey.shade200.withOpacity(0.9),
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.network(
                                      '${dashboardData[index].image}',
                                      width: dashboardData[index].path == '/sgb'
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
    );
  }
}
