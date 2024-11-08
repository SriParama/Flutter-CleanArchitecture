// import 'package:flutter/material.dart';

// class PersistentSnackbar extends StatefulWidget {
//   final String message;
//   final VoidCallback onClose;

//   PersistentSnackbar({required this.message, required this.onClose});

//   @override
//   _PersistentSnackbarState createState() => _PersistentSnackbarState();
// }

// class _PersistentSnackbarState extends State<PersistentSnackbar> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.black87,
//       padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Expanded(
//             child: Text(
//               widget.message,
//               style: TextStyle(color: Colors.white),
//             ),
//           ),
//           TextButton(
//             onPressed: widget.onClose,
//             child: Text(
//               'Close',
//               style: TextStyle(color: Colors.white),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
// custom_persistent_notification.dart
import 'package:flutter/material.dart';
import 'package:novoapp/core/theme/app_colors.dart';

class CustomPersistentNotification extends StatelessWidget {
  final String message;
  final VoidCallback onClose;

  CustomPersistentNotification({required this.message, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
            color: appPrimeColor, borderRadius: BorderRadius.circular(20)),
        padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                message,
                style: TextStyle(color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: onClose,
              child: Text(
                'Close',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
