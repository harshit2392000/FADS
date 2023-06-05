import 'package:fadsapp/data/repositories/notification_repo.dart';
import 'package:fadsapp/models/notification_model.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  final NotificationRepo notificationRepo;

  List<NotificationItem> notifications = [];

  NotificationController({required this.notificationRepo});

  Future<void> getNotificationList() async {
    Response response = await notificationRepo.getNotificationList();
    // print(response.bodyString);
    for (var i in response.body) {
      NotificationItem item = NotificationItem.fromJSON(i);
      notifications.add(item);
    }
    update();
  }
}
