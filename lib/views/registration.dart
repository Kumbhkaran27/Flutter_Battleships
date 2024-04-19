import 'package:flutter/material.dart';
import 'package:battleships/utils/http_service.dart';

class RegistrationPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  HttpService httpService = HttpService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New Player Registration')),
      body: Padding(
        padding: EdgeInsets.all(20.0), // Add padding here
        child: Form(
          child: Column(
            children: [
              TextField(
                controller: usernameController,
                decoration: InputDecoration(labelText: 'Enter New Username:'),
              ),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(labelText: 'Enter Password:'),
                obscureText: true,
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 20.0),
              ),
              TextButton(
                onPressed: () {
                  httpService
                      .registerUser(usernameController.text,
                          passwordController.text, context)
                      .then((response) {
                    if (response['statusCode'] == 200) {
                      httpService.showAlertDialog(context,
                          'Registration Successful', 'You can now login');
                    } else {
                      httpService.showAlertDialog(
                          context, 'Registration Failed', response['message']);
                    }
                  });
                },
                child: const Text('Click here to Register New Account'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
