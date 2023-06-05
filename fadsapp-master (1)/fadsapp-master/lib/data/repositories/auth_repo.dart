import 'package:fadsapp/data/api/api_client.dart';
import 'package:fadsapp/utils/app_constants.dart';
import 'package:get/get.dart';

class AuthRepo extends GetxService {
  final ApiClient apiClient;

  AuthRepo({required this.apiClient});

  Future<Response> sendOtp(int phone) async {
    return await apiClient
        .postData(AppConstants.sendOtpUrl, {"phoneNumber": phone});
  }

  Future<Response> verifyOtp(int otp) async {
    return await apiClient.postData(AppConstants.verifyOtpUrl, {"otp": otp});
  }
}
