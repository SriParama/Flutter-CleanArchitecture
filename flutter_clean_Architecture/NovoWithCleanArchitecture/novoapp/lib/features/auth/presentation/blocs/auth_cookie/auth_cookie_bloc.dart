// import 'dart:async';
// import 'dart:io';

// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:novoapp/core/error/failure.dart';
// import 'package:novoapp/features/auth/domine/use_cases/getCurrentCookie_usecase.dart';
// import 'package:novoapp/features/auth/domine/use_cases/is_LoggedIn_usecase.dart';
// import 'package:novoapp/features/auth/domine/use_cases/logged_out_usecase.dart';

// part 'auth_cookie_event.dart';
// part 'auth_cookie_state.dart';

// class AuthCookieBloc extends Bloc<AuthCookieEvent, AuthCookieState> {
//   final IsLoggedInUseCase isLoggedInUseCase;
//   final LoggedOutUseCase loggedOutUseCase;
//   final GetCurrentCookieUseCase getCurrentCookieUseCase;
//   AuthCookieBloc(
//       {required this.isLoggedInUseCase,
//       required this.loggedOutUseCase,
//       required this.getCurrentCookieUseCase})
//       : super(AuthCookieInitial()) {
//     on<AuthIsLoginEvent>(authIsLogin);

//     on<AuthLogOutEvent>(authLogout);
//   }

//   // Future<void> appStarted() async {
//   //   try {
//   //     final isSignIn = await isLoggedInUseCase.call();

//   //     if (isSignIn) {
//   //       final cookie = await getCurrentCookieUseCase.call();
//   //       emit(Authenticated(cookie: cookie));
//   //     } else {
//   //       emit(UnAuthenticated());
//   //     }
//   //   } on SocketException catch (_) {
//   //     emit(UnAuthenticated());
//   //   }
//   // }

//   // Future<void> loggedIn() async {
//   //   try {
//   //     final isSignIn = await isLogInUseCase.call();

//   //     if (isSignIn) {
//   //       final cookie = await getCurrentCookieUseCase.call();
//   //       emit(Authenticated(cookie: cookie));
//   //     } else {
//   //       emit(UnAuthenticated());
//   //     }
//   //   } catch (_) {
//   //     emit(UnAuthenticated());
//   //   }
//   // }

//   // Future<void> loggedOut() async {
//   //   try {
//   //     await logOutUseCase.logOut();
//   //     emit(UnAuthenticated());
//   //   } catch (_) {
//   //     emit(UnAuthenticated());
//   //   }
//   // }

// //   FutureOr<void> authIsLogin(
// //     AuthIsLoginEvent event,
// //     Emitter<AuthCookieState> emit,
// //   ) async {
// //     emit(AuthCookieInitial());
// //     try {
// //       var res = await isLoggedInUseCase.call();
// //       print("res");
// //       print(res);

// //       res.fold((failure) => emit(AuthCookieInvalid()), (response) {
// //         if (response) {
// //           final cookie = getCurrentCookieUseCase.call();
// //           print(cookie.toString());
// //           emit(AuthCookieValidated(cookie: cookie.toString()));
// //         } else {
// //           print('failed else');
// //           emit(AuthCookieInvalid());
// //         }
// //       });
// //     } on SocketException catch (e) {
// //       print(e.toString());
// //       emit(AuthCookieInvalid());
// //     } catch (e) {
// //       print(e.toString());
// //       emit(AuthCookieInvalid());
// //     }
// //   }

// //   FutureOr<void> authLogout(
// //     AuthLogOutEvent event,
// //     Emitter<AuthCookieState> emit,
// //   ) async {
// //     emit(AuthCookieInitial());
// //     try {
// //       var res = await isLoggedInUseCase.call();

// //       res.fold((failure) => emit(AuthCookieInvalid()), (response) {
// //         if (response) {
// //           emit(AuthCookieInvalid());
// //         } else {
// //           print('failed else');
// //           emit(AuthCookieInvalid());
// //         }
// //       });
// //     } on SocketException catch (e) {
// //       print(e.toString());
// //       emit(AuthCookieInvalid());
// //     } catch (e) {
// //       print(e.toString());
// //       emit(AuthCookieInvalid());
// //     }
// //   }
// // }
