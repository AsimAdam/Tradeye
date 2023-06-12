// ignore_for_file: unused_import, file_names
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<dynamic>> fetchNewsArticles() async {
  final response = await http.get(Uri.parse(
      'https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=7d4d86e08c3f4b5b90cf68713aa93e55'));
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final articles = data['articles'];
    return articles;
  } else {
    throw Exception('Failed to fetch news articles');
  }
}
