import 'package:flutter/material.dart';

void main() {
  runApp(const MyAppicon());
}

class MyAppicon extends StatelessWidget {
  const MyAppicon({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: 'Flutter layout demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter layout demo'),
      ),
      body: ListView(
        children: const <Widget>[
          ListTile(
            leading: Icon(Icons.circle, color: Colors.blue),
            title: Text('วงกลม', style: TextStyle(color: Colors.blue)),
            subtitle: Text('Circle', style: TextStyle(color: Colors.red)),
          ),
          ListTile(
            leading: Icon(Icons.square, color: Colors.blue),
            title: Text('สี่เหลี่ยม', style: TextStyle(color: Colors.blue)),
            subtitle: Text('Rectangle', style: TextStyle(color: Colors.red)),
          ),
          ListTile(
            leading: Icon(Icons.square_rounded, color: Colors.blue),
            title:
                Text('สี่เหลี่ยมมุมมน', style: TextStyle(color: Colors.blue)),
            subtitle:
                Text('Rectangle Rounded', style: TextStyle(color: Colors.red)),
          ),
          ListTile(
            leading: Icon(Icons.fire_truck, color: Colors.blue),
            title: Text('รถดับเพลิง', style: TextStyle(color: Colors.blue)),
            subtitle: Text('Fire Truck', style: TextStyle(color: Colors.red)),
          ),
          ListTile(
            leading: Icon(Icons.camera, color: Colors.blue),
            title: Text('กล้องถ่ายรูป', style: TextStyle(color: Colors.blue)),
            subtitle: Text('Camera', style: TextStyle(color: Colors.red)),
          ),
          ListTile(
            leading: Icon(Icons.girl, color: Colors.blue),
            title: Text('เด็กผู้หญิง', style: TextStyle(color: Colors.blue)),
            subtitle: Text('Girl', style: TextStyle(color: Colors.red)),
          ),
          ListTile(
            leading: Icon(Icons.bed, color: Colors.blue),
            title: Text('เตียงนอน', style: TextStyle(color: Colors.blue)),
            subtitle: Text('Bed', style: TextStyle(color: Colors.red)),
          ),
          ListTile(
            leading: Icon(Icons.cake, color: Colors.blue),
            title: Text('เค้ก', style: TextStyle(color: Colors.blue)),
            subtitle: Text('Cake', style: TextStyle(color: Colors.red)),
          ),
          ListTile(
            leading: Icon(Icons.diamond, color: Colors.blue),
            title: Text('เพขร', style: TextStyle(color: Colors.blue)),
            subtitle: Text('Diamond ', style: TextStyle(color: Colors.red)),
          ),
          ListTile(
            leading: Icon(Icons.headphones, color: Colors.blue),
            title: Text('หูฟัง', style: TextStyle(color: Colors.blue)),
            subtitle: Text('Headphones', style: TextStyle(color: Colors.red)),
          ),
          ListTile(
            leading: Icon(Icons.icecream, color: Colors.blue),
            title: Text('ไอศครีม', style: TextStyle(color: Colors.blue)),
            subtitle: Text('Ice Cream', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
