import 'package:flutter/material.dart';
import 'package:novoapp/core/common/persistentSnackbar.dart';
import 'package:novoapp/core/theme/app_colors.dart';

void showSnackBar(BuildContext context, String content, Color bgcolor) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(
      content: Text(
        content,
        style: const TextStyle(fontSize: 14.0, color: Colors.white),
        textAlign: TextAlign.left,
      ),
      backgroundColor: bgcolor,
      duration: const Duration(seconds: 3),
      dismissDirection: DismissDirection.up,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height * 0.05,
          left: 10,
          right: 10),
      elevation: 20,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      // behavior: SnackBarBehavior.fixed,
    ));
}

// void showPersistentSnackbar(BuildContext context, String message) {
//   ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//       content: PersistentSnackbar(
//         message: message,
//         onClose: () {
//           // ScaffoldMessenger.of(context).hideCurrentSnackBar();
//         },
//       ),
//       duration: Duration(hours: 1),
//       behavior: SnackBarBehavior.fixed,
//       dismissDirection: ,
//       backgroundColor: Colors.transparent,
//       elevation: 0,
//     ),
//   );
// }
// overlay_service.dart

class OverlayService {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static OverlayEntry? _overlayEntry;

  static void showPersistentNotification(String message, VoidCallback onClose) {
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        // top: MediaQuery.of(context).size.height - 100,
        left: 0,
        right: 0,
        bottom: 40,
        child: CustomPersistentNotification(
          message: message,
          onClose: () {
            hidePersistentNotification();
            onClose();
          },
        ),
      ),
    );

    navigatorKey.currentState?.overlay?.insert(_overlayEntry!);
  }

  static void hidePersistentNotification() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
