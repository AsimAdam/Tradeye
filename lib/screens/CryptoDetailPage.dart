// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, file_names

import 'package:flutter/material.dart';
import 'package:krypto/model/CryptoItem.dart';

class CryptoDetailPage extends StatelessWidget {
  final CryptoItem cryptoItem;

  CryptoDetailPage({required this.cryptoItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(cryptoItem.name),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(top: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(cryptoItem.imageUrl),
                  radius: 50,
                ),
                SizedBox(height: 16),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Table(
                    columnWidths: {
                      0: FlexColumnWidth(1),
                      1: FlexColumnWidth(2),
                    },
                    children: [
                      _buildTableRow('Symbol', cryptoItem.symbol),
                      _buildTableRow('Price',
                          '\$${cryptoItem.currentPrice.toStringAsFixed(2)}'),
                      _buildTableRow('Change 24h',
                          cryptoItem.priceChange24h.toStringAsFixed(2)),
                      _buildTableRow('Change %',
                          '${cryptoItem.priceChangePercentage24h.toStringAsFixed(2)}%'),
                      _buildTableRow('Last Updated', cryptoItem.lastUpdated),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TableRow _buildTableRow(String label, String value) {
    return TableRow(
      children: [
        TableCell(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        TableCell(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text(value),
          ),
        ),
      ],
    );
  }
}
