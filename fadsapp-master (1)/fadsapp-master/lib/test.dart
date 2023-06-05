import 'package:flutter/material.dart';

class OtpAuthPage extends StatefulWidget {
  @override
  _OtpAuthPageState createState() => _OtpAuthPageState();
}

class _OtpAuthPageState extends State<OtpAuthPage> {
  String? phoneNo;
  String? otp;
  bool _otpVisible = false;
  String message = '';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('OTP Authentication'),
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
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                    key: _formKey,
                    child: Column(children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                          prefixIcon: Icon(Icons.phone),
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a phone number';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          phoneNo = value;
                        },
                      ),
                      SizedBox(height: 20.0),
                      _otpVisible
                          ? Column(children: <Widget>[
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'OTP',
                                  prefixIcon: Icon(Icons.vpn_key),
                                ),
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter the OTP';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  otp = value;
                                },
                              ),
                              SizedBox(height: 20.0),
                              ElevatedButton(
                                  child: Text('Verify'),
                                  onPressed: () {
                                    // if (_formKey.currentState.validate()) {
                                    //   _formKey.currentState.save();
                                    // Verify the OTP here.
                                    // You can use a package like 'dio' to make an HTTP request to a server to verify the OTP
                                    // Navigate to the next page on successful verification
                                    // Navigator.of(context)
                                    //     .pushRepl
                                    // }
                                  })
                            ])
                          : Text("just yesting")
                    ])))));
  }
}
