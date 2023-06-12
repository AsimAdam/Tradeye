// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, file_names

import 'package:flutter/material.dart';
import 'package:krypto/model/EventClass.dart';

class EventDetailsPage extends StatelessWidget {
  final Event event;
  const EventDetailsPage({required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          padding: EdgeInsets.all(10),
          child: ListView(
            children: [
              Image.network(event.image),
              SizedBox(height: 10),
              Text(
                event.title,
                style: TextStyle(fontSize: 22),
              ),
              SizedBox(height: 10),
              Text(
                event.date,
                style: TextStyle(color: Colors.amber),
              ),
              SizedBox(height: 10),
              Text(
                event.description,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
