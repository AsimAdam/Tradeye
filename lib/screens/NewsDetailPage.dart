// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';

class NewsDetailPage extends StatelessWidget {
  final String image;
  final String publisher;
  final String datePublished;
  final String description;

  const NewsDetailPage({
    required this.image,
    required this.publisher,
    required this.datePublished,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Details'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Image.network(image),
          SizedBox(height: 16),
          Text(
            publisher,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            datePublished,
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
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
