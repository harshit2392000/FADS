import 'package:fadsapp/controllers/notification_controller.dart';
import 'package:fadsapp/models/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<NotificationItem> notifications =
      Get.find<NotificationController>().notifications;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Notifications'),
        ),
        body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.blue[300]!,
                  Colors.blue[100]!,
                ],
              ),
            ),
            child: GetBuilder<NotificationController>(
              builder: (notcon) => ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 4.0,
                      child: ListTile(
                        leading: const Icon(
                          Icons.notifications,
                          color: Colors.blue,
                        ),
                        title: Text(
                          notifications[index].title!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        subtitle: Text(
                          notifications[index].description!,
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                        onTap: () {
                          // navigate to detail page
                        },
                      ),
                    ),
                  );
                },
              ),
            )));
  }
}
