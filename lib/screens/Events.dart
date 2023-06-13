// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors, file_names, unused_label, dead_code, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:krypto/screens/Feed.dart';
import 'package:krypto/screens/News.dart';
import 'EventDetailPage.dart';
import 'dart:convert';
import 'package:share/share.dart';
import 'package:krypto/model/EventClass.dart';

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
      throw Exception('Failed to fetch Events');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Latest Events',
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];
          return EventItem(
            image: event.image,
            title: event.title,
            date: event.date,
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
              Padding(
                padding: EdgeInsets.only(right: 16.0),
                child: IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () {
                    _shareEvent(context);
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.grey.shade200),
              ),
              onPressed: onPressed,
              child: Text(
                'Details',
                style: TextStyle(color: Colors.black),
              ),
            ),
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
