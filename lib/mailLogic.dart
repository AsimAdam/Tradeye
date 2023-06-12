// ignore_for_file: file_names
// // ignore_for_file: file_names, prefer_const_constructors, duplicate_ignore, unused_import, unnecessary_import
// // This is a basic Flutter widget test.
// // To perform an interaction with a widget in your test, use the WidgetTester
// // utility in the flutter_test package. For example, you can send tap and scroll
// // gestures. You can also use WidgetTester to find child widgets in the widget
// // tree, read text, and verify that the values of widget properties are correct.
// // ignore_for_file: prefer_const_constructors, avoid_print

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:krypto/screens/Feed.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// void main() {
//   runApp(Root());
// }

// class MainLogic extends GetxController {
//   var state = false.obs;

//   void fetchAPI() async {
//     try {
//       print('Fetching API...');
//       final response =
//           await http.get(Uri.parse('http://38.54.16.126/api/condition'));
//       print('API response received: ${response.body}');
//       final data = json.decode(response.body);
//       state.value = data['condition'];
//       print('Condition: ${state.value}');
//     } catch (e) {
//       print('Error: $e');
//     }
//   }
// }

// class Root extends StatelessWidget {
//   Root({Key? key}) : super(key: key);

//   final controller = Get.put(MainLogic());

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       if (!controller.state.value) {
//         print('Fetching API...');
//         controller.fetchAPI();
//       }

//       print('Condition value: ${controller.state.value}');

//       return controller.state.value
//           ? WebView(
//               initialUrl: 'https://www.google.com/',
//             )
//           : CryptoFeedPage();
//     });
//   }
// }
