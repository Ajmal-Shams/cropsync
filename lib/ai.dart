import 'package:flutter/material.dart';

class AIPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AI'),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Text(
          'This is the AI Page',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }
}
