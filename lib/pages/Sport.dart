// ignore_for_file: prefer_const_constructors, duplicate_import, use_key_in_widget_constructors, sized_box_for_whitespace, library_private_types_in_public_api, deprecated_member_use, file_names, unused_element, unused_import

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:krypto/pages/CatDetails.dart';

class CustomListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 48.0,
        height: 48.0,
        child: Icon(Icons.account_circle),
      ),
      title: Text('Title'),
      subtitle: Text('Subtitle'),
    );
  }
}

class SportPage extends StatefulWidget {
  @override
  _SportPageState createState() => _SportPageState();
}

class _SportPageState extends State<SportPage> {
  List<dynamic> news = [];

  final String apiKey = 'bc9643018bde4c329efcccb6c564392d';
  final String sportNewsUrl =
      'https://newsapi.org/v2/top-headlines?country=us&category=sports&apiKey=bc9643018bde4c329efcccb6c564392d';

  late Future<void> _sportNewsFuture;

  @override
  void initState() {
    super.initState();
    _sportNewsFuture = fetchNews();
  }

  Future<void> fetchNews() async {
    final response = await http.get(Uri.parse(sportNewsUrl));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final articles = data['articles'];
      setState(() {
        news = articles.map((article) {
          final imageUrl = article['urlToImage'];
          final completeImageUrl = '$imageUrl';

          return {
            ...article,
            'urlToImage': completeImageUrl,
          };
        }).toList();
      });
    }
  }

  Future<void> _refreshData() async {
    setState(() {
      _sportNewsFuture = fetchNews();
    });
  }

  void makeArticleOffline(int index) {
    setState(() {
      news[index]['isOffline'] = true;
    });
    // Perform the necessary actions to make the article available offline, such as downloading and saving the article content locally.
  }

  void removeArticleOffline(int index) {
    setState(() {
      news[index]['isOffline'] = false;
    });
    // Perform the necessary actions to remove the article from offline availability.
  }

  String formatPublishedAt(String publishedAt) {
    final parsedDate = DateTime.parse(publishedAt);
    final now = DateTime.now();
    final difference = now.difference(parsedDate);

    if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
    } else {
      return 'Just now';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 3, 49, 109),
        title: Text(
          'Latest News',
          style: TextStyle(fontSize: 18),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _refreshData,
          ),
        ],
      ),
      body: FutureBuilder<void>(
        future: _sportNewsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return Container(
              margin: EdgeInsets.only(top: 10),
              child: ListView.builder(
                itemCount: news.length,
                itemBuilder: (context, index) {
                  final article = news[index];
                  final title = article['title'];
                  final urlToImage = article['urlToImage'];
                  final author = article['author'];
                  final publishedAt = article['publishedAt'];
                  final description = article['description'];
                  final isOffline = article['isOffline'] ?? false;

                  return Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 2, 34, 53),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 160,
                    margin: EdgeInsets.only(bottom: 5),
                    child: ListTile(
                      title: Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          backgroundColor: Color.fromARGB(255, 2, 34, 53),
                          color: Colors.white,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 8),
                          Text(
                            'By $author',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.yellow,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Published: ${formatPublishedAt(publishedAt)}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      leading: urlToImage != null
                          ? Image.network(
                              urlToImage,
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            )
                          : Container(),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: isOffline
                                    ? Icon(Icons.offline_bolt,
                                        color: Colors.white)
                                    : Icon(Icons.download, color: Colors.white),
                                onPressed: () {
                                  if (isOffline) {
                                    removeArticleOffline(index);
                                  } else {
                                    makeArticleOffline(index);
                                  }
                                },
                              ),
                              SizedBox(width: 4),
                              Text(
                                isOffline ? 'Offline' : 'Download',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TechDetailPage(
                              image: urlToImage ?? '',
                              publisher: author ?? '',
                              datePublished: publishedAt ?? '',
                              description: description ?? '',
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
