// ignore_for_file: deprecated_member_use, use_build_context_synchronously
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import 'register.dart';
import 'nextscreen.dart';
import 'package:mysql1/mysql1.dart';

class Mysql {
  static String host = '127.0.0.1', user = 'root', db = 'flutter_database';
  static int port = 3306;
  Mysql();

  Future<MySqlConnection> getconnection() async {
    var settings = ConnectionSettings(
      host: host,
      port: port,
      user: user,
      db: db,
    );
    return await MySqlConnection.connect(settings);
  }
}

void main() {
  runApp(
    MaterialApp(
      title: 'Named Routes Demo',
      initialRoute: '/',
      routes: {
        '/': (context) => const SignIn(),
        '/second': (context) => const Register(),
        '/next_screen': (context) => const NextScreen(),
      },
    ),
  );
}

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
        body: Center(
            child: isSmallScreen
                ? const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _Logo(),
                      _FormContent(),
                    ],
                  )
                : Container(
                    padding: const EdgeInsets.all(32.0),
                    constraints: const BoxConstraints(maxWidth: 800),
                    child: const Row(
                      children: [
                        Expanded(child: _Logo()),
                        Expanded(
                          child: Center(child: _FormContent()),
                        ),
                      ],
                    ),
                  )));
  }
}

class _Logo extends StatelessWidget {
  const _Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FlutterLogo(size: isSmallScreen ? 100 : 200),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Welcome to My App",
            textAlign: TextAlign.center,
            style: isSmallScreen
                ? Theme.of(context).textTheme.headline5
                : Theme.of(context)
                    .textTheme
                    .headline4
                    ?.copyWith(color: Colors.black),
          ),
        )
      ],
    );
  }
}

class _FormContent extends StatefulWidget {
  const _FormContent({Key? key}) : super(key: key);

  @override
  State<_FormContent> createState() => __FormContentState();
}

class __FormContentState extends State<_FormContent> {
  bool _isPasswordVisible = false;
  bool _rememberMe = false;
  Mysql mysql = Mysql();

  TextEditingController codeController = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController PasswordController = TextEditingController();

  // ignore: unused_element
  Future<void> _performLogin() async {
    MySqlConnection conn = await mysql.getconnection();
    // ignore: duplicate_ignore
    try {
      String code = codeController.text;
      String password = PasswordController.text;

      var results = await conn.query(
        'SELECT * FROM users WHERE code = ? AND password = ?',
        [code, password],
      );

      if (results.isNotEmpty) {
        // Login successful, show success alert
        _showSuccessAlert();

        // Navigate to the next screen using the Navigator
        Navigator.pushReplacementNamed(context, '/next_screen');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid code or password.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error during login: $e');
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred during login.'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      await conn.close();
    }
  }

  void _showSuccessAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Success'),
          content: const Text('Login successful!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 300),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller:
                  codeController, // bind the controller to get the input
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your code';
                }

                // Add your custom validation if needed

                return null;
              },
              decoration: const InputDecoration(
                labelText: 'รหัสประจำตัว',
                hintText: 'กรุณากรอกรหัสประจำตัว',
                prefixIcon: Icon(Icons.email_outlined),
                border: OutlineInputBorder(),
              ),
            ),
            _gap(),
            TextFormField(
              controller:
                  PasswordController, // bind the controller to get the input
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }

                // You may want to add more complex password validation here

                return null;
              },
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Enter your password',
                prefixIcon: const Icon(Icons.lock_outline_rounded),
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(_isPasswordVisible
                      ? Icons.visibility_off
                      : Icons.visibility),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
            ),
            _gap(),
            CheckboxListTile(
              value: _rememberMe,
              onChanged: (value) {
                if (value == null) return;
                setState(() {
                  _rememberMe = value;
                });
              },
              title: const Text('Remember me'),
              controlAffinity: ListTileControlAffinity.leading,
              dense: true,
              contentPadding: const EdgeInsets.all(0),
            ),
            _gap(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    _performLogin();
                  }
                },
              ),
            ),
            _gap(),
            Center(
              child: RichText(
                text: TextSpan(
                  text: 'Not registered? ',
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Create Account',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamed(context, '/second');
                        },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _gap() => const SizedBox(height: 16);
}
