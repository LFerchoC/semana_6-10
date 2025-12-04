import 'package:flutter/material.dart';
import 'package:switch_theme_app/widgets/customs_tile.dart';

class ColorsView extends StatelessWidget {
  const ColorsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Colors view'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomsTile(color: Colors.red),
            CustomsTile(color: Colors.cyan),
            CustomsTile(color: Colors.blue),
            CustomsTile(color: Colors.yellow),
            CustomsTile(color: Colors.amber),
            CustomsTile(color: Colors.deepOrange),
            CustomsTile(color: Colors.teal),
            CustomsTile(color: Colors.pink),
            CustomsTile(color: Colors.purple),
            CustomsTile(color: Colors.lime),
            CustomsTile(color: Colors.green),
            CustomsTile(color: Colors.brown),
            CustomsTile(color: Colors.deepOrangeAccent),
            CustomsTile(color: Colors.limeAccent),
          ],
        ),
      ),
    );
  }
}
