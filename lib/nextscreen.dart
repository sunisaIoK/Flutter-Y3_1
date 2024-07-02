// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
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

class NextScreen extends StatelessWidget {
  const NextScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Next Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to the Next Screen!',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate back to the login screen
                Navigator.pop(context);
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
