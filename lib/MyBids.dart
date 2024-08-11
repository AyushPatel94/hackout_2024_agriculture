import 'package:flutter/material.dart';

class MyBids extends StatelessWidget {
  MyBids({super.key});

  final List<Map<String, dynamic>> bids = [
    {
      'cropName': 'Wheat',
      'bidAmount': 5000,
      'bidDate': DateTime(2024, 7, 20),
      'status': 'Accepted'
    },
    {
      'cropName': 'Rice',
      'bidAmount': 3000,
      'bidDate': DateTime(2024, 8, 5),
      'status': 'Pending'
    },
    // Add more bids here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        color: Colors.grey[200],
        child: ListView.builder(
          itemCount: bids.length,
          itemBuilder: (context, index) {
            final bid = bids[index];
            return Card(
              margin: const EdgeInsets.all(10.0),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    bid['cropName'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black87,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.currency_rupee_rounded, color: Colors.green.shade700),
                            SizedBox(width: 5),
                            Text(
                              '${bid['bidAmount'].toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(Icons.calendar_today, color: Colors.blue),
                            SizedBox(width: 5),
                            Text(
                              'Date: ${bid['bidDate'].toLocal().toString().split(' ')[0]}',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: bid['status'] == 'Accepted'
                                  ? Colors.green.shade700
                                  : Colors.orange,
                            ),
                            SizedBox(width: 5),
                            Text(
                              'Status: ${bid['status']}',
                              style: TextStyle(
                                fontSize: 16,
                                color: bid['status'] == 'Accepted'
                                    ? Colors.green
                                    : Colors.orange,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
