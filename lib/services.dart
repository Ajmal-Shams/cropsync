import 'package:flutter/material.dart';

class ServicesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Services'),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Text(
          'This is the Services Page',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }
}
