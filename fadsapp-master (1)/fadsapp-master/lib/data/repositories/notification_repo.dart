import 'package:fadsapp/data/api/api_client.dart';
import 'package:fadsapp/utils/app_constants.dart';
import 'package:get/get.dart';

class NotificationRepo extends GetxService {
  final ApiClient apiClient;

  NotificationRepo({required this.apiClient});

  Future<Response> getNotificationList() async {
    return await apiClient.getData(AppConstants.notificationUrl);
  }
}
