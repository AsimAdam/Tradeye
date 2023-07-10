// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:krypto/pages/Technology.dart';

class Category {
  final String title;
  final String image;

  Category(this.title, this.image);
}

class CategoriesPage extends StatelessWidget {
  final List<Category> categories = [
    Category('Technology', 'assets/technology.jpg'),
    Category('Finance', 'assets/finance.jpg'),
    Category('Sport', 'assets/Sport.jpg'),
    Category('Health', 'assets/Health.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
        backgroundColor: Color.fromARGB(255, 3, 49, 109),
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => TechnologyPage()));
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: 300,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  image: DecorationImage(
                    image: AssetImage(category.image),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: Colors.black.withOpacity(0.3),
                  ),
                  child: Center(
                    child: Text(
                      category.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
