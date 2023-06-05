import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpInputContainer extends StatelessWidget {
  final TextEditingController? controller;
  final Function? setValue;
  const OtpInputContainer({this.controller, this.setValue, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 48,
      decoration: BoxDecoration(
        border: Border.all(width: 1.0, color: Colors.blue),
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      ),
      child: TextFormField(
        controller: controller,
        autofocus: true,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.blue,
          fontSize: 20,
        ),
        onChanged: (value) {
          if (value.length == 1) {
            if (setValue != null) setValue!();
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }
}
