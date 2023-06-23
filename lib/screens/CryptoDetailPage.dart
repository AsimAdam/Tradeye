// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, file_names

import 'package:flutter/material.dart';
import 'package:krypto/model/CryptoItem.dart';
import 'package:intl/intl.dart';

class CryptoDetailPage extends StatelessWidget {
  final CryptoItem cryptoItem;

  CryptoDetailPage({required this.cryptoItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 3, 49, 109),
        title: Text(
          cryptoItem.name,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
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
                  Text(
                    'Updated ${cryptoItem.name} Price',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: Color.fromARGB(255, 3, 49, 109)),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color:
                              Color.fromARGB(255, 3, 49, 109).withOpacity(0.9),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Table(
                      columnWidths: {
                        0: FlexColumnWidth(1),
                        1: FlexColumnWidth(2),
                      },
                      children: _buildTableRows(),
                    ),
                  ),
                  // SizedBox(height: 16),
                  // // Add your chart widget here for representing crypto coin situation
                  // Placeholder(
                  //   // Placeholder for chart widget
                  //   fallbackHeight: 200,
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<TableRow> _buildTableRows() {
    final formattedDate =
        DateFormat.yMMMMd().format(DateTime.parse(cryptoItem.lastUpdated));

    final rows = <TableRow>[
      _buildTableRow('Symbol', cryptoItem.symbol),
      _buildDividerRow(),
      _buildTableRow(
          'Price', '\$${cryptoItem.currentPrice.toStringAsFixed(2)}'),
      _buildDividerRow(),
      _buildTableRow(
          'Change 24h', cryptoItem.priceChange24h.toStringAsFixed(2)),
      _buildDividerRow(),
      _buildTableRow('Change %',
          '${cryptoItem.priceChangePercentage24h.toStringAsFixed(2)}%'),
      _buildDividerRow(),
      _buildTableRow('Last Updated', formattedDate),
    ];

    return rows;
  }

  TableRow _buildTableRow(String label, String value) {
    return TableRow(
      children: [
        TableCell(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text(
              label,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.yellow),
            ),
          ),
        ),
        TableCell(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text(
              value,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  TableRow _buildDividerRow() {
    return TableRow(
      children: [
        TableCell(
          child: Divider(
            thickness: 5,
            color: Colors.black12,
          ),
        ),
        TableCell(
          child: Divider(
            thickness: 5,
            color: Colors.black12,
          ),
        ),
      ],
    );
  }
}
