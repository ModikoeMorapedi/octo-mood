import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
      ),
    );
  }
}
