import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: mainColor,
          foregroundColor: Colors.black,
          centerTitle: true,
          title: const Text('Notifications')),
      body: const Center(
        child: Text(
          'There is no notification for now',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
