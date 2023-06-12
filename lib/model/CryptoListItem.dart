// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, file_names, library_private_types_in_public_api, prefer_const_literals_to_create_immutables, duplicate_import

import 'package:flutter/material.dart';

class CryptoListItem extends StatelessWidget {
  final String name;
  final String symbol;
  final String imageUrl;
  final String currentPrice;
  final String priceChangePercentage;

  const CryptoListItem({
    required this.name,
    required this.symbol,
    required this.imageUrl,
    required this.currentPrice,
    required this.priceChangePercentage,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(imageUrl),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name),
          Text(symbol),
        ],
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(currentPrice, style: TextStyle(fontWeight: FontWeight.bold)),
          Text(priceChangePercentage),
        ],
      ),
    );
  }
}
