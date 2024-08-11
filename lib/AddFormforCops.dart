import 'dart:convert';
import 'dart:io';
import 'package:abcd/Home_screenFarmer.dart';
import 'package:abcd/Home_screen_buyer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddProductForm extends StatefulWidget {
  @override
  _AddProductFormState createState() => _AddProductFormState();
}

class _AddProductFormState extends State<AddProductForm> {
  File? _imageFile;
  List<File?> imageList = [];
  String Category = "Vegetables";
  TextEditingController cropName = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController quantity = TextEditingController();
  TextEditingController startingBid = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController notes = TextEditingController();
  String measure = 'Kg';
  final _formKey = GlobalKey<FormState>();

  void optionBottomSheet(double screenHeight) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: screenHeight * 0.25,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: Colors.white,
          ),
          child: Column(
            children: [
              imageSelectOptions(
                  screenHeight,
                  'Select from gallery',
                  ImageSource.gallery,
                  Colors.black,
                  Icon(Icons.browse_gallery)),
              imageSelectOptions(screenHeight, 'Select from camera',
                  ImageSource.camera, Colors.black, Icon(Icons.camera)),
            ],
          ),
        );
      },
    );
  }

  Widget imageSelectOptions(double screenHeight, String s,
      ImageSource? imageSource, Color color, Icon icon) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        height: screenHeight * 0.07,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () async {
            if (imageSource != null) {
              await selectFile(imageSourcee: imageSource);
              Navigator.pop(context);
            } else {
              setState(() {
                _imageFile = null;
              });
              Navigator.pop(context);
              Navigator.pop(context);
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(s), icon],
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: color,
            textStyle: TextStyle(
              fontSize: 16,
            ),
            elevation: 20,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
        ),
      ),
    );
  }

  selectFile({required ImageSource imageSourcee}) async {
    final pickedFile = await ImagePicker().pickImage(
        source: imageSourcee, preferredCameraDevice: CameraDevice.front);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        imageList.add(_imageFile);
      });
    } else {
      print("No file selected.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreenFarmer(),));
        }, icon: Icon(Icons.arrow_back,color: Colors.white,)),
        title: Text('Add Product',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  onTap: () {
                    optionBottomSheet(MediaQuery.of(context).size.height);
                  },
                  readOnly: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.add),
                    disabledBorder: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                    hintText: "Add Image"
                  ),
                ),
                Container(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: imageList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Text(imageList[index]!
                            .path
                            .split(Platform.pathSeparator)
                            .last,style: TextStyle(fontSize: 20),),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: cropName,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                    labelText: 'Product Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the product name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),

                // Category Dropdown
                DropdownButtonFormField<String>(
                  value: Category,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                    labelText: 'Category',
                  ),
                  items: ['Vegetables', 'Fruits', 'Grains', 'Dairy']
                      .map((category) => DropdownMenuItem<String>(
                            value: category,
                            child: Text(category),
                          ))
                      .toList(),
                  onChanged: (value) {
                    // Handle category selection
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  maxLines: 4,
                  controller: description,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                    labelText: 'Product Description',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Flexible(
                      flex: 2,
                      child: TextFormField(
                        controller: quantity,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(),
                          labelText: 'Quantity Available In $measure',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the quantity';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      child: DropdownButtonFormField<String>(
                        value: measure,
                        onChanged: (value) {
                          setState(() {
                            measure = value!;
                          });
                        },
                        items: [
                          DropdownMenuItem(value: "Kg", child: Text("Kg")),
                          DropdownMenuItem(value: "Ton", child: Text("Ton")),
                        ],
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          border: UnderlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: startingBid,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.currency_rupee),
                    suffix: Text("Per $measure"),
                    enabledBorder: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                    labelText: 'Starting Bid Price',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the bid price';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),

                // Location
                TextFormField(
                  controller: location,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                    labelText: 'Location',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the location';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),

                // Additional Notes
                TextFormField(
                  controller: notes,
                  maxLines: 2,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                    labelText: 'Additional Notes',
                  ),
                ),
                SizedBox(height: 20),

                // Centered Submit Button
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Processing Data')),
                        );
                        SharedPreferences pref =
                            await SharedPreferences.getInstance();
                        Map<String, dynamic> User =
                            await jsonDecode(pref.getString("user")!);
                        List<String> imagesUrl = [];
                        Reference referenceRoot =
                            FirebaseStorage.instance.ref();
                        Reference referenceDirImg =
                            referenceRoot.child('Images');
                        for (int i = 0; i < imageList.length; i++) {
                          if (imageList[i] != null) {
                            try {
                              String uniqFileName = DateTime.now()
                                  .microsecondsSinceEpoch
                                  .toString();
                              Reference refImgToUpld = referenceDirImg
                                  .child(uniqFileName + i.toString());
                              await refImgToUpld
                                  .putFile(File(imageList[i]!.path));
                              imagesUrl
                                  .add(await refImgToUpld.getDownloadURL());
                            } catch (error) {
                              print(error.toString());
                            }
                          }
                        }
                        try {
                          await FirebaseFirestore.instance
                              .collection('crops')
                              .doc()
                              .set({
                            'farmerName': User["userName"],
                            'cropName': cropName.text,
                            'description': description.text,
                            'category': Category,
                            'quantity': quantity.text,
                            'startingBid': startingBid.text,
                            'location': location.text,
                            'notes': notes.text,
                            'measure':measure,
                            'date': DateFormat.yMMMd().format(DateTime.now()),
                            'images': imagesUrl,
                            'status':'active'
                          });
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreenFarmer(),));
                        } catch (error) {
                          print(error.toString());
                        }
                      }
                    },
                    child: Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
