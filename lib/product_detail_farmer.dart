import 'dart:convert';

import 'package:abcd/myCrops.dart';
import 'package:abcd/place_bids.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'See_bids.dart';

class CropDetailPageFarmer extends StatefulWidget {
  final product;

  CropDetailPageFarmer({super.key, required this.product});

  @override
  State<CropDetailPageFarmer> createState() => _CropDetailPageFarmerState();
}

class _CropDetailPageFarmerState extends State<CropDetailPageFarmer> {
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
        backgroundColor: Colors.green[700],
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 25),
        ),
        title: Text(
          'Product Details',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CarouselSlider(
                items: List.generate(
                  widget.product['images'].length,
                  (index) => ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      widget.product['images'][index],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                options: CarouselOptions(
                  aspectRatio: 1,
                  viewportFraction: 0.8,
                  enlargeCenterPage: true,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeading('Product Information'),
                  _buildDetailRow('Name', widget.product['cropName']),
                  _buildDetailRow('Description', widget.product['description']),
                  _buildDetailRow('Quantity', widget.product['quantity']),
                  _buildDetailRow('Category', widget.product['category']),

                  SizedBox(height: 16), // Space before next section
                  _buildHeading('Bidding Details'),
                  _buildDetailRow(
                      'Starting Bid', widget.product['startingBid']),
                  _buildDetailRow('Location', widget.product['location']),

                  SizedBox(height: 16), // Space before next section
                  _buildHeading('Additional Information'),
                  _buildDetailRow('Additional Note', widget.product['notes']),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        try {
                          DocumentReference ref = FirebaseFirestore.instance
                              .collection('crops')
                              .doc(widget.product['reference']);
                          widget.product.remove('reference');
                          widget.product['status'] = 'inactive';
                          setState(() {});
                          ref.set(widget.product);
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => userCrops(),
                            ),
                          );
                        } catch (error) {
                          print(error);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[700],
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        padding: EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 30.0),
                      ),
                      child: Text(
                        'End Bid',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ViewBidsScreen(),
                            ));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[700],
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        padding: EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 30.0),
                      ),
                      child: Text(
                        'See Bids',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeading(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.green[700],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              value ?? 'N/A',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
