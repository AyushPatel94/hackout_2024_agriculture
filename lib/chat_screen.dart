import 'package:flutter/material.dart';

class QueryForumScreen extends StatelessWidget {
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: Colors.green,
      elevation: 0,
      title: Text(
        'Chat',
        style: TextStyle(color: Colors.white),
      ),
      centerTitle: true,
    ),
    body: Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        children: [
          SizedBox(height: 20),
          _buildQueryItem(context, 'Chamatkar', 'assets/chamatkar.jpg'),
          SizedBox(height: 20),
          _buildQueryItem(context, 'Acemain', 'assets/acemain.jpg'),
        ],
      ),
    ),
  );
}

Widget _buildQueryItem(BuildContext context, String title, String imagePath) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    decoration: BoxDecoration(
      color: Colors.grey[100],
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      children: [
        CircleAvatar(
          backgroundImage: AssetImage(imagePath),
          radius: 30,
        ),
        SizedBox(width: 20),
        Expanded(
          child: Text(
            title,
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
        ),
        TextButton(
          onPressed: () {
            // Handle "Open" button press
          },
          child: Text(
            'Open',
            style: TextStyle(color: Colors.green),
          ),
        ),
      ],
    ),
  );
}
}