// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors, file_names, unused_label, dead_code, deprecated_member_use, unused_import

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'EventDetailPage.dart';
import 'dart:convert';
import 'package:share/share.dart';
import 'package:krypto/model/EventClass.dart';
import 'package:intl/intl.dart';

class EventPage extends StatefulWidget {
  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  List<Event> events = [];

  @override
  void initState() {
    super.initState();
    fetchEvents();
  }

  Future<void> fetchEvents() async {
    final response = await http.get(Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=7d4d86e08c3f4b5b90cf68713aa93e55'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<Event> fetchedEvents = [];
      for (var eventData in data['articles']) {
        final image = eventData['urlToImage'] ?? '';
        final title = eventData['title'] ?? '';
        final date = eventData['publishedAt'] ?? '';
        final description =
            eventData['description'] ?? 'No description available';

        final event = Event(
          image: image,
          title: title,
          date: date,
          description: description,
        );
        fetchedEvents.add(event);
      }
      setState(() {
        events = fetchedEvents;
      });
    } else {
      throw Exception('Failed to fetch Trends');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 3, 49, 109),
        title: Text(
          'Latest Trends',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
      body: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];
          final formattedDate =
              DateFormat.yMMMMd().format(DateTime.parse(event.date));
          return EventItem(
            image: event.image,
            title: event.title,
            date: formattedDate,
            description: event.description,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EventDetailsPage(event: event)),
              );
            },
          );
        },
      ),
    );
  }
}

class EventItem extends StatelessWidget {
  final String image;
  final String title;
  final String date;
  final String description;
  final VoidCallback onPressed;

  const EventItem({
    required this.image,
    required this.title,
    required this.date,
    required this.description,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      margin: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.network(
            image,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 16.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: Text(
                  date,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey,
                  ),
                ),
              ),
              Row(
                children: [
                  ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromARGB(255, 3, 49, 109),
                      ),
                    ),
                    onPressed: onPressed,
                    icon: Icon(Icons.fullscreen),
                    label: Text(
                      'Full Story',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.share),
                    onPressed: () {
                      _shareEvent(context);
                    },
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16.0),
        ],
      ),
    );
  }

  void _shareEvent(BuildContext context) {
    final RenderBox box = context.findRenderObject() as RenderBox;
    final String text = 'Check out this event: $title\n\n$date';
    Share.share(text,
        subject: title,
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }
}
