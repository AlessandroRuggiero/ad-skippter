import 'package:flutter/material.dart';

import 'home.dart';
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar (
        title: Text ("Ad Skipper"),
      ),
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(child: Home()),
      )),
    );
  }
}