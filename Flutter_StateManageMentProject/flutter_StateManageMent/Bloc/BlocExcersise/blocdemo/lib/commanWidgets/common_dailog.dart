// import 'package:blocdemo/GlobleBlocs/navigationBloc/bloc/navigation_bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// // Define a function to show a global custom alert dialog
// void showGlobalCustomDialog({
//   // required GlobalKey<NavigatorState> navigatorKey,
//   // required String title,
//   // required String content,
//   // String? cancelButtonText,
//   // String? confirmButtonText,
//   // VoidCallback? onConfirm,
//   // VoidCallback? onCancel,
// }) {
//   showDialog(
//     context: navigatorKey.currentContext!,
//     builder: (context) {
//       return AlertDialog(
//         title: Text(title),
//         content: Text(content),
//         actions: [
//           if (cancelButtonText != null)
//             TextButton(
//               onPressed: () {
//                 onCancel?.call();
//                 BlocProvider.of<NavigationBloc>(context)
//                     .add(GlobleNavigationPop());
//                 // Navigator.of(context).pop(); // Close the dialog
//               },
//               child: Text(cancelButtonText),
//             ),
//           if (confirmButtonText != null)
//             ElevatedButton(
//               onPressed: () {
//                 onConfirm?.call();
//                 BlocProvider.of<NavigationBloc>(context)
//                     .add(GlobleNavigationPop()); // Close the dialog
//               },
//               child: Text(confirmButtonText),
//             ),
//         ],
//       );
//     },
//   );
// }
