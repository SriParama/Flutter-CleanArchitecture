import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novoapp/core/ThemeBloc/theme_bloc.dart';
import 'package:novoapp/core/cubits/IndexChange_cubit/index_change_cubit.dart';
import 'package:novoapp/core/theme/app_colors.dart';
import 'package:novoapp/core/theme/theme.dart';
import 'package:novoapp/core/theme/themeprovider.dart';
import 'package:novoapp/features/auth/presentation/blocs/auth_cookie_cubit/auth_cookie_cubit.dart';
import 'package:novoapp/features/novo/data/novo_data_source/models/novoModel/dashboard_model.dart';
import 'package:novoapp/features/novo/presentation/pages/ipopage.dart';
import 'package:provider/provider.dart';

class NovoDashBoardScreen extends StatefulWidget {
  final List<SegmentArr> dashboardData;
  // final String ClientId;
  const NovoDashBoardScreen({super.key, required this.dashboardData});

  @override
  State<NovoDashBoardScreen> createState() => _NovoDashBoardScreenState();
}

class _NovoDashBoardScreenState extends State<NovoDashBoardScreen> {
  @override
  void initState() {
    context.read<AuthCookieCubit>().loggedIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final themeBloc = BlocProvider.of<ThemeBloc>(context);
    // final lightTheme = themeBloc.state.themeMode == ThemeMode.light;
    // final darkTheme = themeBloc.state.themeMode == ThemeMode.dark;
    final darkTheme =
        Provider.of<NavigationProvider>(context).themeMode == ThemeMode.dark;
    // final getTheme = GetTheme();
    return Column(
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
              Text('Primary Market',
                  style: darkTheme
                      ? ThemeClass.Darktheme.textTheme.headlineMedium
                      : ThemeClass.Lighttheme.textTheme.headlineMedium),
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
            ],
          ),
        ),
        // isLoading
        //     ? const Expanded(child: Center(child: loadingProgress()))
        //     :
        widget.dashboardData.isEmpty
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
                      itemCount: widget.dashboardData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: widget.dashboardData[index].status == 'Y'
                              ? () {
                                  // BlocProvider.of<AuthCookieCubit>(context)
                                  //     .loggedIn();
                                  // context
                                  //     .read<AuthCookieCubit>()
                                  //     .loggedIn();
                                  context
                                      .read<IndexChangeCubit>()
                                      .changeIndex(0);
                                  // Navigator.push(context, MaterialPageRoute(
                                  //   builder: (context) {
                                  //     return IpoPage();
                                  //   },
                                  // ));
                                  widget.dashboardData[index].path == '/ipo'
                                      ? context
                                          .read<IndexChangeCubit>()
                                          .changeIndex(1)
                                      : widget.dashboardData[index].path ==
                                              '/sgb'
                                          ? context
                                              .read<IndexChangeCubit>()
                                              .changeIndex(2)
                                          : widget.dashboardData[index].path ==
                                                  '/gsec'
                                              ? context
                                                  .read<IndexChangeCubit>()
                                                  .changeIndex(3)
                                              : context
                                                  .read<IndexChangeCubit>()
                                                  .changeIndex(0);
                                }
                              : null,
                          child: Visibility(
                            visible: widget.dashboardData[index].status == 'Y',
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: darkTheme
                                        ? const Color.fromARGB(
                                                255, 230, 228, 228)
                                            .withOpacity(0.1)
                                        : Colors.grey.shade200.withOpacity(0.9),
                                    offset: const Offset(
                                      5.0,
                                      5.0,
                                    ),
                                    blurRadius: 20.0,
                                    spreadRadius: 10.0,
                                  ), //BoxShadow
                                  BoxShadow(
                                    color: darkTheme
                                        ? const Color.fromRGBO(48, 48, 48, 1)
                                        : Colors.white,
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
                                    darkTheme
                                        ? '${widget.dashboardData[index].darkThemeImage}'
                                        : '${widget.dashboardData[index].image}',
                                    width: widget.dashboardData[index].path ==
                                            '/sgb'
                                        ? 82
                                        : 60,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            const SizedBox(),
                                  ),
                                  // : Image.network(
                                  //     '${widget.dashboardDetails[index].image}',
                                  //     width: widget.dashboardDetails[index]
                                  //                 .path ==
                                  //             '/sgb'
                                  //         ? 82
                                  //         : 60,
                                  //     errorBuilder:
                                  //         (context, error, stackTrace) =>
                                  //             const SizedBox(),
                                  //   ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    widget.dashboardData[index].name!,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        fontFamily: 'Kiro'),
                                  ),
                                ],
                              ),
                            ),

                            //  Container(
                            //   decoration: BoxDecoration(
                            //     boxShadow: [
                            //       BoxShadow(
                            //         color:
                            //             Colors.grey.shade200.withOpacity(0.9),
                            //         offset: const Offset(
                            //           5.0,
                            //           5.0,
                            //         ),
                            //         blurRadius: 20.0,
                            //         spreadRadius: 10.0,
                            //       ), //BoxShadow
                            //       BoxShadow(
                            //         color: Colors.white,
                            //         offset: const Offset(
                            //           0.0,
                            //           0.0,
                            //         ),
                            //         blurRadius: 0.0,
                            //         spreadRadius: 5.0,
                            //       ), //BoxShadow
                            //     ],
                            //     borderRadius: BorderRadius.circular(10.0),
                            //   ),
                            //   child: Column(
                            //     mainAxisAlignment: MainAxisAlignment.center,
                            //     crossAxisAlignment: CrossAxisAlignment.center,
                            //     children: [
                            //       Image.network(
                            //         '${widget.dashboardData[index].image}',
                            //         width: widget.dashboardData[index].path ==
                            //                 '/sgb'
                            //             ? 82
                            //             : 60,
                            //         errorBuilder:
                            //             (context, error, stackTrace) =>
                            //                 const SizedBox(),
                            //       ),
                            //       const SizedBox(
                            //         height: 10.0,
                            //       ),
                            //       Text(
                            //         widget.dashboardData[index].name!,
                            //         style: const TextStyle(
                            //             fontWeight: FontWeight.bold,
                            //             fontSize: 20,
                            //             fontFamily: 'Kiro'),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                          ),
                        );
                      }),
                ),
              ),
      ],
    );
  }
}
