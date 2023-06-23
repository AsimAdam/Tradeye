// ignore_for_file: unused_import, file_names, depend_on_referenced_packages, use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 3, 49, 109),
        title: Text(
          'About',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder<PackageInfo>(
              future: PackageInfo.fromPlatform(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final packageInfo = snapshot.data!;
                  return Column(
                    children: [
                      Image.asset(
                        'assets/tradeye.png',
                        width: 100,
                        height: 100,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Version: ${packageInfo.version}',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text(
                    'Error loading package info: ${snapshot.error}',
                    style: TextStyle(fontSize: 18),
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
