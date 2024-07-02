import 'package:flutter/material.dart';

void main() {
  runApp(const MyAppGrid());
}

class MyAppGrid extends StatelessWidget {
  const MyAppGrid({super.key});

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
      body: GridView.builder(
        itemCount: 30,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(3.0),
            child: GridTile(
              footer: GridTileBar(
                backgroundColor: Colors.black45,
                title: Text('ภาพที่ ${index + 1}'),
              ),
              child: Image.network(
                  'https://source.unsplash.com/random?sig=$index',
                  fit: BoxFit.cover),
            ),
          );
        },
      ),
    );
  }
}
