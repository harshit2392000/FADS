import 'package:fadsapp/controllers/notification_controller.dart';
import 'package:fadsapp/pages/auth/otp_auth_page.dart';
import 'package:fadsapp/pages/notification_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'helpers/dependencies.dart' as dep;

Future main() async {
  await dep.init();
  print("was here");
  Get.find<NotificationController>().getNotificationList();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/otp-auth-page',
      home: Scaffold(
          body: Container(
              child: const Text(
        'Home Page',
      ))),
      routes: {
        '/otp-auth-page': (context) => OtpAuthPage(),
        '/notification-page': (context) => NotificationPage(),
      },
    );
  }
}
