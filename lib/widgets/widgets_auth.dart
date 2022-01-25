// Widget Login
import 'package:flutter/material.dart';

Widget wAuthTitle(String title, String subtitle) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.only(bottom: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 3),
        Text(subtitle),
      ],
    ),
  );
}

Widget wTextDivider() {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10),
    child: Row(
      children: const <Widget>[
        Expanded(child: Divider()),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'OR CONNECT WITH',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ),
        Expanded(child: Divider()),
      ],
    ),
  );
}
