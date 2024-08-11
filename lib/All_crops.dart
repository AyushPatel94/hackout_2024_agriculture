import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'crop_page.dart';

class AllCrops extends StatefulWidget {
  AllCrops({super.key});

  @override
  State<AllCrops> createState() => _AllCropsState();
}

class _AllCropsState extends State<AllCrops> {
  TextEditingController _searchText = TextEditingController();
  Color? greenColor = Colors.green[700];
  List<Map<String, dynamic>> productList = [];

  List<Map<String, dynamic>> filteredList = [];

  @override
  void initState() {
    super.initState();
    _loadCrops().then((value) {
      setState(() {
        List<QueryDocumentSnapshot> documents = value.docs;
        for(int i=0;i<documents.length;i++){
          Map<String,dynamic> map = documents[i].data() as Map<String, dynamic>;
          map['reference'] = documents[i].id;
          if(map['status']=='active'){
            productList.add(map as Map<String,dynamic>);
          }
        }
        _searchText.text.isEmpty
            ? filteredList = productList
            : filteredList = productList.where((product) {
                final searchLower = _searchText.text.toLowerCase();
                final productName = product['cropName']?.toLowerCase() ?? '';
                final description = product['description']?.toLowerCase() ?? '';

                return productName.contains(searchLower) ||
                    description.contains(searchLower);
              }).toList();
      });
    });
  }

  _loadCrops() async {
    return await FirebaseFirestore.instance.collection('crops').get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
            child: TextFormField(
              onChanged: (value) {
                setState(() {
                  filteredList = productList.where((product) {
                    final searchLower = _searchText.text.toLowerCase();
                    final productName =
                        product['cropName']?.toLowerCase() ?? '';
                    final description =
                        product['description']?.toLowerCase() ?? '';

                    return productName.contains(searchLower) ||
                        description.contains(searchLower);
                  }).toList();
                });
              },
              controller: _searchText,
              cursorColor: Colors.white,
              style: TextStyle(
                color: Colors.white
              ),
              decoration: InputDecoration(
                fillColor: Colors.green.shade700,
                filled: true,
                hintText: 'Search',
                hintStyle: TextStyle(
                  color: Colors.white
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                final product = filteredList[index];
                return Card(
                  margin: EdgeInsets.all(10.0),
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Stack(
                      children: [
                        // Background image or color
                        Container(
                          height: 300,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(product['images'][0]),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.3),
                                  BlendMode.darken),
                            ),
                          ),
                        ),
                        Container(
                          height: 300,
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.4),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CropPage(product: product),
                                ),
                              );
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product['cropName'] ?? 'No Name',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Description: ${product['description'] ?? 'N/A'}',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white70),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Quantity: ${product['quantity'] ?? 'N/A'}',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Category: ${product['category'] ?? 'N/A'}',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Starting Bid: ${product['startingBid'] ?? 'N/A'}',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Location: ${product['location'] ?? 'N/A'}',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Farmer Name: ${product['farmerName'] ?? 'N/A'}',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                                Spacer(),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CropPage(product: product),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green[700],
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                    child: Text(
                                      'View Details',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
