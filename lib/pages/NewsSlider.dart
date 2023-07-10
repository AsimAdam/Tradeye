// ignore_for_file: prefer_const_constructors, duplicate_import, use_key_in_widget_constructors, sized_box_for_whitespace, library_private_types_in_public_api, deprecated_member_use, file_names, unused_element

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:krypto/pages/Trending.dart';
import 'package:krypto/pages/NewsDetail.dart';
import 'package:krypto/pages/NewsDetail.dart';
import 'package:krypto/pages/Updates.dart';

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

class CryptoNewsPage extends StatefulWidget {
  @override
  _CryptoNewsPageState createState() => _CryptoNewsPageState();
}

class _CryptoNewsPageState extends State<CryptoNewsPage> {
  List<dynamic> news = [];

  final String apiKey = '7d4d86e08c3f4b5b90cf68713aa93e55';

  late Future<void> _cryptoNewsFuture;

  @override
  void initState() {
    super.initState();
    _cryptoNewsFuture = fetchNews();
  }

  Future<void> fetchNews() async {
    final url =
        'https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=$apiKey';

    final response = await http.get(Uri.parse(url));
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
      _cryptoNewsFuture = fetchNews();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        future: _cryptoNewsFuture,
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
            return ListView.separated(
              itemCount: news.length,
              separatorBuilder: (context, index) => Divider(
                thickness: 5,
              ),
              itemBuilder: (context, index) {
                final article = news[index];
                final title = article['title'];
                final urlToImage = article['urlToImage'];
                final author = article['author'];
                final publishedAt = article['publishedAt'];
                final description = article['description'];

                return Container(
                  height: 100,
                  child: ListTile(
                    title: Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
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
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Published: $publishedAt',
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
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewsDetailPage(
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
            );
          }
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: SvgPicture.asset(
                    'images/home.svg',
                    width: 40,
                    height: 40,
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.black
                        : Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CryptoFeedPage()),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    'Home',
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.black
                          : Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: SvgPicture.asset(
                    'images/news.svg',
                    width: 40,
                    height: 40,
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.black
                        : Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CryptoNewsPage()),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    'News',
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.black
                          : Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: SvgPicture.asset(
                    'images/calendar.svg',
                    width: 40,
                    height: 40,
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.black
                        : Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EventPage()),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    'Events',
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.black
                          : Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
