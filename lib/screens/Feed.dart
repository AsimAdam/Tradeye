// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_literals_to_create_immutables, prefer_const_constructors, duplicate_import, unnecessary_null_comparison, file_names, unused_import, prefer_typing_uninitialized_variables, deprecated_member_use, duplicate_ignore
// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_literals_to_create_immutables, prefer_const_constructors, duplicate_import, unnecessary_null_comparison, file_names, unused_import, prefer_typing_uninitialized_variables, deprecated_member_use

// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_literals_to_create_immutables, prefer_const_constructors, duplicate_import, unnecessary_null_comparison, file_names, unused_import, prefer_typing_uninitialized_variables, deprecated_member_use, duplicate_ignore
// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_literals_to_create_immutables, prefer_const_constructors, duplicate_import, unnecessary_null_comparison, file_names, unused_import, prefer_typing_uninitialized_variables, deprecated_member_use

// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_literals_to_create_immutables, prefer_const_constructors, duplicate_import, unnecessary_null_comparison, file_names, unused_import, prefer_typing_uninitialized_variables, deprecated_member_use, duplicate_ignore
// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_literals_to_create_immutables, prefer_const_constructors, duplicate_import, unnecessary_null_comparison, file_names, unused_import, prefer_typing_uninitialized_variables, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:krypto/model/CryptoItem.dart';
import 'package:krypto/screens/Events.dart';
import 'package:krypto/screens/Help.dart';
import 'package:krypto/screens/News.dart';
import 'package:krypto/screens/PrivacyPolicy.dart';
import 'package:krypto/screens/Register.dart';
import 'package:krypto/screens/CryptoDetailPage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CryptoFeedPage extends StatefulWidget {
  @override
  _CryptoFeedPageState createState() => _CryptoFeedPageState();
}

class _CryptoFeedPageState extends State<CryptoFeedPage> {
  late Future<List<CryptoItem>> _cryptoItemsFuture;
  List<CryptoItem> filteredCryptoItems = [];
  bool _isPrivacyPolicyExpanded = false;
  bool _isAboutExpanded = false;

  @override
  void initState() {
    super.initState();
    _cryptoItemsFuture = fetchCryptocurrencies();
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

  Future<void> _refreshData() async {
    setState(() {
      _cryptoItemsFuture = fetchCryptocurrencies();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Search crypto updates',
            prefixIcon: IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _refreshData();
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.transparent,
          width: MediaQuery.of(context).size.width * 0.5,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.close,
                        size: 35,
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.black
                            : Colors.white,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: IconButton(
                  icon: Icon(
                    Icons.privacy_tip,
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.black
                        : Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPrivacyPolicyExpanded = !_isPrivacyPolicyExpanded;
                    });
                  },
                  iconSize: 35,
                ),
                title: DefaultTextStyle(
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.black
                        : Colors.white,
                    fontSize: 18,
                  ),
                  child: Text('Privacy & Policy'),
                ),
                trailing: _isPrivacyPolicyExpanded
                    ? Icon(Icons.keyboard_arrow_down)
                    : Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  setState(() {
                    _isPrivacyPolicyExpanded = !_isPrivacyPolicyExpanded;
                  });
                },
              ),
              if (_isPrivacyPolicyExpanded) ...[
                ListTile(
                  title: Text('Privacy Policy Content'),
                ),
                ListTile(
                  title: InkWell(
                    child: Text(
                      'Learn More',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PrivacyPolicyApple()));
                    },
                  ),
                ),
              ],
              if (_isPrivacyPolicyExpanded) ListTile(),
              ListTile(
                leading: IconButton(
                  icon: Icon(
                    Get.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.black
                        : Colors.white,
                  ),
                  onPressed: () {
                    Get.changeThemeMode(
                      Get.isDarkMode ? ThemeMode.light : ThemeMode.dark,
                    );
                  },
                  iconSize: 35,
                ),
                title: DefaultTextStyle(
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.black
                        : Colors.white,
                    fontSize: 18,
                  ),
                  child: Text(Get.isDarkMode ? 'Light' : 'Dark'),
                ),
                trailing: null,
              ),
              ListTile(
                leading: IconButton(
                  icon: Icon(
                    Icons.info,
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.black
                        : Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      _isAboutExpanded = !_isAboutExpanded;
                    });
                  },
                  iconSize: 35,
                ),
                title: DefaultTextStyle(
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.black
                        : Colors.white,
                    fontSize: 18,
                  ),
                  child: Text('About'),
                ),
                trailing: _isAboutExpanded
                    ? Icon(Icons.keyboard_arrow_down)
                    : Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  setState(() {
                    _isAboutExpanded = !_isAboutExpanded;
                  });
                },
              ),
              if (_isAboutExpanded)
                ListTile(
                  title: Text('Version 1.0.0'),
                ),
            ],
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: FutureBuilder<List<CryptoItem>>(
          future: _cryptoItemsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child:
                    Text('Error fetching cryptocurrencies: ${snapshot.error}'),
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
                    return Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(cryptoItem.imageUrl),
                          ),
                          title: Text(cryptoItem.name),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Symbol: ${cryptoItem.symbol}',
                                style: TextStyle(color: Colors.amber),
                              ),
                              Text(
                                'Price: \$${cryptoItem.currentPrice.toStringAsFixed(2)}',
                                style: TextStyle(color: Colors.green),
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => CryptoDetailPage(
                                cryptoItem: cryptoItem,
                              ),
                            ));
                          },
                        ),
                        Divider(),
                      ],
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
