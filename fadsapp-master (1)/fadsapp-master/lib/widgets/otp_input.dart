import 'package:fadsapp/widgets/otp_input_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpInput extends StatefulWidget {
  final Function setOtpValue;
  const OtpInput({required this.setOtpValue, super.key});

  @override
  State<OtpInput> createState() => _OtpInputState();
}

class _OtpInputState extends State<OtpInput> {
  final _otp1Controller = TextEditingController();
  final _otp2Controller = TextEditingController();
  final _otp3Controller = TextEditingController();
  final _otp4Controller = TextEditingController();

  void setValue() {
    String value = _otp1Controller.text +
        _otp2Controller.text +
        _otp3Controller.text +
        _otp4Controller.text;
    widget.setOtpValue(value);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        OtpInputContainer(
          controller: _otp1Controller,
          setValue: setValue,
        ),
        const SizedBox(width: 10),
        OtpInputContainer(
          controller: _otp2Controller,
          setValue: setValue,
        ),
        const SizedBox(width: 10),
        OtpInputContainer(
          controller: _otp3Controller,
          setValue: setValue,
        ),
        const SizedBox(width: 10),
        OtpInputContainer(
          controller: _otp4Controller,
          setValue: setValue,
        ),
      ],
    ));
  }
}
