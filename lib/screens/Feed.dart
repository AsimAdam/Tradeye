// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_declarations, prefer_const_constructors, file_names, avoid_print

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:krypto/model/CryptoItem.dart';
import 'package:krypto/screens/About.dart';
import 'package:krypto/screens/CryptoDetailPage.dart';
import 'package:krypto/screens/Events.dart';
import 'package:krypto/screens/NewsDetailPage.dart';
import 'package:krypto/screens/PrivacyPageGoogle.dart';

class CryptoFeedPage extends StatefulWidget {
  @override
  _CryptoFeedPageState createState() => _CryptoFeedPageState();
}

class _CryptoFeedPageState extends State<CryptoFeedPage> {
  late Future<List<CryptoItem>> _cryptoItemsFuture;
  List<CryptoItem> filteredCryptoItems = [];

  late Future<List<Article>> _newsFuture;
  List<Article> newsList = [];

  @override
  void initState() {
    super.initState();
    _cryptoItemsFuture = fetchCryptocurrencies();
    _newsFuture = fetchNews();
  }

  Future<List<CryptoItem>> fetchCryptocurrencies() async {
    final Uri url = Uri.parse(
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=10&page=1');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List<dynamic>;
      final cryptoItems =
          data.map((item) => CryptoItem.fromJson(item)).toList();
      return cryptoItems;
    } else {
      throw Exception('Failed to fetch cryptocurrencies');
    }
  }

  Future<List<Article>> fetchNews() async {
    final String apiKey = '7d4d86e08c3f4b5b90cf68713aa93e55';
    final Uri url = Uri.parse(
        'https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=$apiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final articles = data['articles'] as List<dynamic>;
      print(data);
      final newsItems = articles.map((item) => Article.fromJson(item)).toList();
      return newsItems;
    } else {
      throw Exception('Failed to fetch news');
    }
  }

  Future<void> _refreshData() async {
    setState(() {
      _cryptoItemsFuture = fetchCryptocurrencies();
      _newsFuture = fetchNews();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 3, 49, 109),
        title: Row(
          children: [
            SizedBox(width: 16),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CryptoFeedPage()));
              },
              child: Image.asset(
                'assets/tradeye.png',
                width: 40,
              ),
            ),
          ],
        ),
      ),
      endDrawer: Drawer(
        child: Container(
          color: Color.fromARGB(255, 3, 49, 109),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: Icon(
                    Icons.home,
                    size: 30,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Home',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CryptoFeedPage()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.trending_up,
                    size: 30,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Trending',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EventPage()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.privacy_tip,
                    size: 30,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Privacy & Policy',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PrivacyPolicyGoogle()),
                    );
                  },
                ),
                SizedBox(height: 16),
                ListTile(
                  leading: Icon(
                    Icons.info,
                    size: 30,
                    color: Colors.white,
                  ),
                  title: Text(
                    'About',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AboutPage()),
                    );
                  },
                ),
                Spacer(),
                Text(
                  '@ all right reserved Tradeye 2023',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        color: Color.fromARGB(255, 218, 224, 226),
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<Article>>(
                future: _newsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Error fetching news: ${snapshot.error}',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  } else if (snapshot.hasData) {
                    final newsItems = snapshot.data!;
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: newsItems.length,
                      itemBuilder: (context, index) {
                        final newsItem = newsItems[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NewsDetailPage(
                                  image: newsItem.imageUrl,
                                  publisher: newsItem.publisher,
                                  datePublished: newsItem.datePublished,
                                  description: newsItem.description,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            width: 200,
                            margin: EdgeInsets.only(right: 16),
                            child: Card(
                              color: Colors.white,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Image.network(
                                      newsItem.imageUrl,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Text(
                                      newsItem.title,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Color.fromARGB(255, 2, 34, 53),
                ),
                child: FutureBuilder<List<CryptoItem>>(
                  future: _cryptoItemsFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          'Error fetching cryptocurrencies: ${snapshot.error}',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    } else if (snapshot.hasData) {
                      final cryptoItems = snapshot.data!;
                      filteredCryptoItems = cryptoItems;
                      return RefreshIndicator(
                        onRefresh: _refreshData,
                        child: ListView.builder(
                          itemCount: filteredCryptoItems.length,
                          itemBuilder: (context, index) {
                            final cryptoItem = filteredCryptoItems[index];
                            return Container(
                              margin: EdgeInsets.only(bottom: 16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Color.fromARGB(255, 3, 49, 109),
                              ),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(cryptoItem.imageUrl),
                                ),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      cryptoItem.name,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            cryptoItem.symbol,
                                            style: TextStyle(
                                              color: Colors.yellow,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '\$${cryptoItem.currentPrice.toStringAsFixed(2)}',
                                          style: TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CryptoDetailPage(
                                        cryptoItem: cryptoItem,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Article {
  final String title;
  final String imageUrl;
  final String publisher;
  final String datePublished;
  final String description;

  Article({
    required this.title,
    required this.imageUrl,
    required this.publisher,
    required this.datePublished,
    required this.description,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] ?? '',
      imageUrl: json['urlToImage'] ?? '',
      publisher:
          json['source']['name'] ?? '', // Access "name" attribute in "source"
      datePublished: json['publishedAt'] ?? '',
      description: json['description'] ?? '',
    );
  }
}
