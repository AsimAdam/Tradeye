// ignore_for_file: unused_import, prefer_typing_uninitialized_variables, file_names

import 'package:flutter/material.dart';

class CryptoItem {
  final String name;
  final String symbol;
  final String imageUrl;
  final double currentPrice;
  final double priceChange24h;
  final double priceChangePercentage24h;
  final String lastUpdated;

  CryptoItem({
    required this.name,
    required this.symbol,
    required this.imageUrl,
    required this.currentPrice,
    required this.priceChange24h,
    required this.priceChangePercentage24h,
    required this.lastUpdated,
  });

  factory CryptoItem.fromJson(Map<String, dynamic> json) {
    return CryptoItem(
      name: json['name'],
      symbol: json['symbol'],
      imageUrl: json['image'],
      currentPrice: json['current_price'].toDouble(),
      priceChange24h: json['price_change_24h'].toDouble(),
      priceChangePercentage24h: json['price_change_percentage_24h'].toDouble(),
      lastUpdated: json['last_updated'],
    );
  }
}
