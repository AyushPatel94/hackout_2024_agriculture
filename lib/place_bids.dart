import 'dart:convert';

import 'package:abcd/MyBids.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlaceBidScreen extends StatefulWidget {
  String image;
  String startingPrice;
  String productName;
  String reference;
  Map<String, dynamic> product;

  PlaceBidScreen(
      {required this.image,
      required this.startingPrice,
      required this.productName,
      required this.reference,
      required this.product});

  @override
  State<PlaceBidScreen> createState() => _PlaceBidScreenState();
}

class _PlaceBidScreenState extends State<PlaceBidScreen> {
  TextEditingController bidAmount = TextEditingController();
  Map<String, dynamic>? User;

  @override
  void initState() {
    inItializeUser().then((value) {
      setState(() {});
    });
    super.initState();
  }

  Future<void> inItializeUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    User = jsonDecode(await pref.getString("user")!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.green[700],
        elevation: 0,
        title: Text(
          'Place Your Bid',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              'Product Details',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(height: 10),
            _buildProductDetails(),
            SizedBox(height: 20),
            Text(
              'Your Bid',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(height: 10),
            _buildBidInputField(),
            Spacer(),
            _buildPlaceBidButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProductDetails() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(widget.image),
            // Replace with your product image
            radius: 40,
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.productName,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                SizedBox(height: 10),
                Text(
                  'Starting Price: ${widget.startingPrice} per kg',
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBidInputField() {
    return TextFormField(
      controller: bidAmount,
      decoration: InputDecoration(
        hintText: 'Enter your bid amount',
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.green),
        ),
      ),
      keyboardType: TextInputType.number,
    );
  }

  Widget _buildPlaceBidButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          await FirebaseFirestore.instance.collection('bids').doc().set({
            'buyerID': User!["userID"],
            'cropID': widget.product['reference'],
            'farmerID': widget.product['farmerID'],
            'bidPrice': bidAmount.text,
            'date': DateFormat.yMMMd().format(DateTime.now()),
          });
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => MyBids(),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          'Place Bid',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}
