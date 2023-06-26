// ignore_for_file: unused_import, file_names
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:krypto/model/CurrencyItem.dart';
import 'package:http/http.dart' as http;

Future<List<CryptoItem>> fetchCryptocurrencies() async {
  final response = await http.get(Uri.parse(
      'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=10&page=1'));
  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);
    return data.map((json) => CryptoItem.fromJson(json)).toList();
  } else {
    throw Exception('Failed to fetch cryptocurrencies');
  }
}
