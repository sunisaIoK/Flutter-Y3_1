// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:form_field_validator/form_field_validator.dart';
// ignore: unnecessary_import
import 'package:flutter/foundation.dart';
// ignore: unused_import
import 'login.dart';
import 'package:flutter/gestures.dart';
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

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  Map userData = {};
  final _formkey = GlobalKey<FormState>();
  Mysql mysql = Mysql(); // Create an instance of the Mysql class

  // Controller for the text form fields
  TextEditingController codeController = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController PasswordController = TextEditingController();
  TextEditingController retypeController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController universityController = TextEditingController();

  Future<void> _insertDataToDatabase() async {
    MySqlConnection conn = await mysql.getconnection();

    try {
      // Extract data from the text form fields
      String code = codeController.text;
      String password = PasswordController.text;
      String retypepassword = retypeController.text;
      String firstname = firstnameController.text;
      String lastname = lastnameController.text;
      String university = universityController.text;

      // Check if the password and retypepassword match
      if (password != retypepassword) {
        // Show an error message if passwords do not match
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Passwords do not match. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
        return; // Exit the method if passwords do not match
      }

      // Insert data into the database
      await conn.query(
        'INSERT INTO users (code, password, firstname, lastname, university) VALUES (?, ?, ?, ?, ?)',
        [code, password, firstname, lastname, university],
      );

      // Show a success message or navigate to the next screen
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Registration successful!'),
        ),
      );

      // Optionally, navigate to another screen
      // Navigator.pushNamed(context, '/next_screen');
    } catch (e) {
      // Handle errors
      if (kDebugMode) {
        print('Error inserting data: $e');
      }
      // Show an error message
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Registration failed. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      await conn.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('register'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Enter code'),
                      MinLengthValidator(3,
                          errorText: 'Minimum 3 characters for code'),
                    ]),
                    decoration: const InputDecoration(
                      hintText: 'Enter code',
                      labelText: 'code',
                      prefixIcon: Icon(
                        Icons.vpn_key,
                        color: Color.fromARGB(255, 173, 173, 173),
                      ),
                      errorStyle: TextStyle(fontSize: 18.0),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.all(Radius.circular(9.0)),
                      ),
                    ),
                    controller:
                        codeController, // Add this line to bind the controller
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Enter Password'),
                      MinLengthValidator(6,
                          errorText: 'Minimum 6 characters for Password'),
                      MaxLengthValidator(15,
                          errorText: 'Maximum 15 characters for Password'),
                    ]),
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'Enter Password (6-15 characters)',
                      labelText: 'Password',
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Color.fromARGB(255, 173, 173, 173),
                      ),
                      errorStyle: TextStyle(fontSize: 18.0),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.all(Radius.circular(9.0)),
                      ),
                    ),
                    controller: PasswordController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Enter Retype Password'),
                      MinLengthValidator(3,
                          errorText: 'Minimum 3 characters for Password'),
                      MaxLengthValidator(15,
                          errorText: 'Maximum 15 characters for Password'),
                    ]),
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'Retype Password (6-15 characters)',
                      labelText: 'Retype Password',
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Color.fromARGB(255, 173, 173, 173),
                      ),
                      errorStyle: TextStyle(fontSize: 18.0),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.all(Radius.circular(9.0)),
                      ),
                    ),
                    controller: retypeController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Enter Firstname'),
                      MinLengthValidator(3,
                          errorText: 'Minimum 3 characters for Firstname'),
                    ]),
                    decoration: const InputDecoration(
                      hintText: 'Enter Firstname',
                      labelText: 'Firstname',
                      prefixIcon: Icon(
                        Icons.person,
                        color: Color.fromARGB(255, 173, 173, 173),
                      ),
                      errorStyle: TextStyle(fontSize: 18.0),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.all(Radius.circular(9.0)),
                      ),
                    ),
                    controller: firstnameController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Enter Lastname'),
                      MinLengthValidator(3,
                          errorText: 'Minimum 3 characters for Lastname'),
                    ]),
                    decoration: const InputDecoration(
                      hintText: 'Enter Lastname',
                      labelText: 'Lastname',
                      prefixIcon: Icon(
                        Icons.person,
                        color: Color.fromARGB(255, 173, 173, 173),
                      ),
                      errorStyle: TextStyle(fontSize: 18.0),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.all(Radius.circular(9.0)),
                      ),
                    ),
                    controller: lastnameController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: MultiValidator([
                      RequiredValidator(
                          errorText: 'Enter University/Organization'),
                      MinLengthValidator(3,
                          errorText:
                              'Minimum 3 characters for University/Organization'),
                    ]),
                    decoration: const InputDecoration(
                      hintText: 'Enter University/Organization',
                      labelText: 'University/Organization',
                      prefixIcon: Icon(
                        Icons.school,
                        color: Color.fromARGB(255, 173, 173, 173),
                      ),
                      errorStyle: TextStyle(fontSize: 18.0),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.all(Radius.circular(9.0)),
                      ),
                    ),
                    controller: universityController,
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () async {
                          if (_formkey.currentState!.validate()) {
                            // Form is valid, proceed with database insertion
                            await _insertDataToDatabase();
                          }
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'CREATE',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: 'Already registered? ',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal, // Set to normal
                        color: Colors.black, // Set the desired color
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Sign in',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(context, '/');
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
