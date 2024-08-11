import 'package:flutter/material.dart';

import 'TransactionDetailsPage.dart';
import 'chat_screen.dart';
class HistoryPage extends StatefulWidget {
  HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  TextEditingController _searchText = TextEditingController();
  Color? greenColor = Colors.green[700];
  final List<Map<String, dynamic>> transactionList = [
    {
      'date': '2024-08-01',
      'buyer': 'John Doe',
      'seller': 'Farmer A',
      'product': 'Wheat',
      'quantity': '10 tons',
      'price': '₹2500',
      'status': 'Completed',
    },
  ];

  List<Map<String, dynamic>> filteredList = [];

  @override
  void initState() {
    super.initState();
    filteredList = transactionList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 25),
        ),
        backgroundColor: greenColor,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            height: 40,
            child: TextFormField(
              onChanged: (value) {
                setState(() {
                  filteredList = transactionList.where((transaction) {
                    final searchLower = value.toLowerCase();
                    final product = transaction['product']?.toLowerCase() ?? '';
                    final buyer = transaction['buyer']?.toLowerCase() ?? '';
                    final seller = transaction['seller']?.toLowerCase() ?? '';

                    return product.contains(searchLower) ||
                        buyer.contains(searchLower) ||
                        seller.contains(searchLower);
                  }).toList();
                });
              },
              controller: _searchText,
              decoration: InputDecoration(
                hintText: 'Search by products',
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none
                ),
              ),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => QueryForumScreen(),));
            },icon: Icon(Icons.chat, color: Colors.white)),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: filteredList.length,
        itemBuilder: (context, index) {
          final transaction = filteredList[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.all(16.0),
              title: Text(
                '${transaction['product']} - ${transaction['quantity']}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black87),
              ),
              subtitle: Text(
                'Buyer: ${transaction['buyer']}\nSeller: ${transaction['seller']}\n'
                    'Price: ${transaction['price']}\nStatus: ${transaction['status']}',
                style: TextStyle(color: Colors.grey[700], fontSize: 14),
              ),
              trailing: Icon(Icons.arrow_forward_ios, color: greenColor),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TransactionDetailsPage(transaction: transaction),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
