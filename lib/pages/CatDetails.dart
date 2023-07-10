// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:krypto/pages/Updates.dart';
import 'package:intl/intl.dart';

class TechDetailPage extends StatelessWidget {
  final String image;
  final String publisher;
  final String datePublished;
  final String description;

  const TechDetailPage({
    required this.image,
    required this.publisher,
    required this.datePublished,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 3, 49, 109),
        title: Text(
          'News Details',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Image.network(image),
          SizedBox(height: 16),
          Text(
            publisher,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 2, 2, 2)),
          ),
          Text(
            DateFormat.yMMMd().format(DateTime.parse(datePublished)),
            style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 2, 2, 2)),
          ),
          SizedBox(height: 8),
          SizedBox(height: 16),
          Text(
            description,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
