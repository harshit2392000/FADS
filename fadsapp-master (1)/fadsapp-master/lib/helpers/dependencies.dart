import 'package:fadsapp/controllers/auth_controller.dart';
import 'package:fadsapp/controllers/notification_controller.dart';
import 'package:fadsapp/data/api/api_client.dart';
import 'package:fadsapp/data/repositories/auth_repo.dart';
import 'package:fadsapp/data/repositories/notification_repo.dart';
import 'package:fadsapp/utils/app_constants.dart';
import 'package:get/get.dart';

Future<void> init() async {
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.baseUrl));

  Get.lazyPut(() => NotificationRepo(apiClient: Get.find<ApiClient>()));
  Get.lazyPut(() => AuthRepo(apiClient: Get.find<ApiClient>()));

  Get.lazyPut(() =>
      NotificationController(notificationRepo: Get.find<NotificationRepo>()));
  Get.lazyPut(() => AuthController(authRepo: Get.find<AuthRepo>()));
}
