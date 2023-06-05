import 'package:fadsapp/data/repositories/auth_repo.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final AuthRepo authRepo;
  String? otp;
  int? phone;
  AuthController({required this.authRepo});

  Future<void> sendOtp() async {
    if (phone != null) {
      print("phone $phone");
      Response res = await authRepo.sendOtp(phone!);
      print(res.bodyString);
    }
  }
}
