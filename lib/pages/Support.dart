// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_const_constructors, prefer_const_declarations, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpSupportPage extends StatelessWidget {
  void _sendEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'support@unitedfuture.tech',
      queryParameters: {'subject': 'Support Inquiry'},
    );
    final String emailUrl = emailUri.toString();
    if (await canLaunch(emailUrl)) {
      await launch(emailUrl);
    } else {
      throw 'Could not launch $emailUrl';
    }
  }

  void _callPhone() async {
    final String phoneUrl = 'tel:+0445298618';
    if (await canLaunch(phoneUrl)) {
      await launch(phoneUrl);
    } else {
      throw 'Could not launch $phoneUrl';
    }
  }

  void _openWebsite() async {
    final String websiteUrl = 'https://www.unitedfuture.tech';
    if (await canLaunch(websiteUrl)) {
      await launch(websiteUrl);
    } else {
      throw 'Could not launch $websiteUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help & Support'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Help & Support',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'For any assistance or inquiries, please feel free to contact our support team.',
              style: TextStyle(
                fontSize: 16.0,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.0),
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: Icon(Icons.email),
                    title: Text('Email'),
                    subtitle: Text('support@unitedfuture.tech'),
                    onTap: _sendEmail,
                  ),
                  ListTile(
                    leading: Icon(Icons.phone),
                    title: Text('Phone'),
                    subtitle: Text('04 529 8618'),
                    onTap: _callPhone,
                  ),
                  ListTile(
                    leading: Icon(Icons.web),
                    title: Text('Website'),
                    subtitle: Text('www.unitedfuture.tech'),
                    onTap: _openWebsite,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
