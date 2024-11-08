import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SecurityScreen extends StatelessWidget {
  const SecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          'Security',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Change Password",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  IconButton(
                      splashColor: null,
                      onPressed: () {},
                      icon: const Icon(CupertinoIcons.forward))
                ],
              ),
            ),
            const Divider(),
            GestureDetector(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Authenticate using TOTP",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  IconButton(
                      splashColor: null,
                      onPressed: () {},
                      icon: const Icon(CupertinoIcons.forward))
                ],
              ),
            ),
            const Divider(),
            GestureDetector(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "FingerPrint",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  IconButton(
                      splashColor: null,
                      onPressed: () {},
                      icon: const Icon(CupertinoIcons.forward))
                ],
              ),
            ),
            const Divider(),
          ],
        ),
      ),
    ));
  }
}
