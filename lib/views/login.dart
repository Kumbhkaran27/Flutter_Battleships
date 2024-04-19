import 'package:battleships/views/gameList.dart';
import 'package:battleships/views/registration.dart';
import 'package:flutter/material.dart';
import 'package:battleships/utils/http_service.dart';
import 'package:battleships/views/gameList.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';
  HttpService httpService = HttpService();

  void _login() async {
    int resp = await httpService.loginUser(_username, _password, context);
    print("hello");
    print(resp);
    if (resp == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => GameListPage(_username)),
      );
    }
  }

  void _navigateToRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegistrationPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return login();
  }

  Widget login() {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login Page',
          style: TextStyle(color: Colors.red,fontSize: 34, // Change font size
                  fontWeight: FontWeight.bold, ), // Change text color
        ),
      ),
      backgroundColor: Colors.grey[300], // Set background color
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch items horizontally
            children: [
              Text(
                'Welcome To Battleships!',
                style: TextStyle(
                  fontSize: 24, // Change font size
                  fontWeight: FontWeight.bold, // Add bold
                  color: Colors.blue, // Change text color
                ),
              ),
              SizedBox(height: 20), // Add spacing between header and text fields
              TextFormField(
                style: TextStyle(color: Colors.black), // Change text color
                decoration: InputDecoration(
                  labelText: 'Username:',
                  filled: true,
                  fillColor: Colors.white, // Set background color of text field
                ),
                onSaved: (value) => _username = value ?? '',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'enter username';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10), // Add spacing between text fields
              TextFormField(
                style: TextStyle(color: Colors.black), // Change text color
                decoration: InputDecoration(
                  labelText: 'Password:',
                  filled: true,
                  fillColor: Colors.white, // Set background color of text field
                ),
                obscureText: true,
                onSaved: (value) => _password = value ?? '',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'enter password';
                  }
                  return null;
                },
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 20.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        _formKey.currentState?.save();
                        _login();
                      }
                    },
                    child: const Text('Login'),
                  ),
                  TextButton(
                    onPressed: _navigateToRegister,
                    child: const Text('Register New Account'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
