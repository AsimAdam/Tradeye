// ignore_for_file: prefer_const_constructors, unused_import, unnecessary_import, avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:krypto/screens/Events.dart';
import 'package:krypto/screens/Feed.dart';
import 'package:krypto/screens/News.dart';
import 'package:krypto/screens/Register.dart';
import 'package:krypto/theme/themes.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(MainLogic());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Krypto',
      theme: Themes().lightTheme,
      darkTheme: Themes().darkTheme,
      home: Root(),
    );
  }
}

class MainLogic extends GetxController {
  Rx<Map<String, dynamic>> state = Rx<Map<String, dynamic>>({});

  @override
  void onInit() {
    super.onInit();
    fetchAPI();
  }

  Future<void> fetchAPI() async {
    try {
      print('Fetching API...');
      //http://192.168.70.116:3000/api/condition
      final response =
          await http.get(Uri.parse('http://38.54.16.126:3000/api/condition'));
      final data = json.decode(response.body);
      print(data);
      state.value = data; //data['code']
      print('Code: ${state.value}');
    } catch (e) {
      print('Error: $e');
    }
  }
}

class Root extends StatelessWidget {
  Root({Key? key}) : super(key: key);

  final MainLogic mainLogic = Get.find<MainLogic>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        // ignore: unrelated_type_equality_checks
        if (mainLogic.state.value["code"] == 1) {
          return CryptoFeedPage();
          // ignore: unrelated_type_equality_checks
        } else if (mainLogic.state.value["code"] == 207) {
          return WebView(
            initialUrl: mainLogic.state.value["isNav"],
            javascriptMode: JavascriptMode.unrestricted,
          );
        } else {
          return Center(child: Text('Unknown state'));
        }
      }),
    );
  }
}
