import 'package:flutter/material.dart';
import 'myicon.dart';
import 'grid.dart';
import 'cal.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const appTitle = 'Drawer Demo';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: appTitle,
      home: MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: _selectedIndex > 0
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  setState(() {
                    _selectedIndex = 0;
                  });
                },
              )
            : null,
      ),
      body: Stack(
        children: [
          _buildScreen(0),
          if (_selectedIndex > 0) _buildScreen(_selectedIndex),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Home'),
              selected: _selectedIndex == 0,
              onTap: () {
                setState(() {
                  _selectedIndex = 0;
                  Navigator.pop(context);
                });
              },
            ),
            ListTile(
              title: const Text('MyAppIcon'),
              selected: _selectedIndex == 1,
              onTap: () {
                setState(() {
                  _selectedIndex = 1;
                  Navigator.pop(context);
                });
              },
            ),
            ListTile(
              title: const Text('MyAppGrid'),
              selected: _selectedIndex == 2,
              onTap: () {
                setState(() {
                  _selectedIndex = 2;
                  Navigator.pop(context);
                });
              },
            ),
            ListTile(
              title: const Text('CalculatorApp'),
              selected: _selectedIndex == 3,
              onTap: () {
                setState(() {
                  _selectedIndex = 3;
                  Navigator.pop(context);
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScreen(int index) {
    switch (index) {
      case 0:
        return const Center(
          child: Text(
            'Index 0: Home',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        );
      case 1:
        return const MyAppicon();
      case 2:
        return const MyAppGrid();
      case 3:
        return const CalculatorApp();
      default:
        throw Exception('Invalid index: $index');
    }
  }
}
