import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/LOGO-JAZZDEV.png'),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'X',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15,
            ),
            Image.asset(
              'assets/LOGO-TRANSPARAN.png',
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        alignment: Alignment.center,
        height: 40,
        child: Text('Copyright 2023 @ Jazzdev'),
        color: Colors.grey.shade300,
      ),
    );
  }
}
