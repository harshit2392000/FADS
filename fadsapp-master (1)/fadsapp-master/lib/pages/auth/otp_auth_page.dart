import 'package:fadsapp/controllers/auth_controller.dart';
import 'package:fadsapp/widgets/otp_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpAuthPage extends StatefulWidget {
  @override
  _OtpAuthPageState createState() => _OtpAuthPageState();
}

class _OtpAuthPageState extends State<OtpAuthPage> {
  String? phoneNo;
  String? otp;
  bool _otpVisible = false;
  String message = '';

  AuthController authController = Get.find<AuthController>();

  void setOtpValue(String value) {
    authController.otp = value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.red),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.blue[300]!,
                  Colors.blue[100]!,
                ],
              ),
            ),
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextField(
                        onChanged: (value) {
                          authController.phone = int.parse(value);
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              width: 2.0,
                              color: Colors.black,
                            ),
                          ),
                          prefixIcon: const Icon(
                            Icons.phone,
                            color: Colors.black,
                          ),
                          hintText: "Enter phone number",
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                          ),
                          labelText: "Phone Number",
                          labelStyle: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        keyboardType: TextInputType.phone,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      _otpVisible
                          ? Column(children: <Widget>[
                              OtpInput(
                                setOtpValue: setOtpValue,
                              ),
                              const SizedBox(height: 20.0),
                              ElevatedButton(
                                  child: const Text('Verify'),
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, '/notification-page');
                                  })
                            ])
                          : ElevatedButton(
                              child: const Text('Next'),
                              onPressed: () {
                                authController.sendOtp();
                                setState(() {
                                  _otpVisible = true;
                                });
                              })
                    ]))));
  }
}
