import 'dart:convert';

import 'package:abcd/ProfileEdit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'All_crops.dart';
import 'HistoryPage.dart';
import 'LogInScreen.dart';
import 'MyBids.dart';
import 'ReduceFoodWastingScreen.dart';
import 'chat_screen.dart';

class HomeScreenBuyer extends StatefulWidget {
  const HomeScreenBuyer({super.key});

  @override
  State<HomeScreenBuyer> createState() => _HomeScreenBuyerState();
}

class _HomeScreenBuyerState extends State<HomeScreenBuyer> {
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

  int _selectedIndex = 0;
  Color? greenColor = Colors.green[700];

  List<Widget> _buildItemList() {
    return [
      AllCrops(),
      MyBids(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: User == null
          ? Center(
              child: CupertinoActivityIndicator(
                color: Colors.green.shade700,
                radius: 30,
              ),
            )
          : Scaffold(
              appBar: AppBar(
                iconTheme: IconThemeData(color: Colors.white),
                backgroundColor: greenColor,
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => QueryForumScreen(),
                            ));
                      },
                      icon: Icon(Icons.chat, color: Colors.white),
                    ),
                  )
                ],
              ),
              drawer: Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    Container(
                      color: Colors.green.shade700,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              User!['userName'],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              User!['phoneNo'],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              User!['userType'],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.person, color: greenColor),
                      title: Text('My Profile'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ProfileEditPage()),
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.history, color: greenColor),
                      title: Text('History'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HistoryPage()),
                        );
                      },
                    ),

                    ListTile(
                      leading: Icon(Icons.contact_mail, color: greenColor),
                      title: Text('Reduce Food Wasting Techniques'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Reducefoodwastingscreen()),
                        );
                      },
                    ),
                    SizedBox(height: 20),
                    ListTile(
                      leading: Icon(Icons.logout, color: Colors.red),
                      title: Text('Logout'),
                      onTap: () async {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(),
                              title: Text("Confirm Logout"),
                              content: Text(
                                  "Are you sure you want to Logout the account? This action cannot be undone."),
                              actions: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pop(); // Close the dialog
                                        },
                                        child: Text(
                                          "Cancel",
                                          style: TextStyle(
                                            color: Colors.blue,
                                          ),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            side:
                                                BorderSide(color: Colors.blue),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          SharedPreferences pref =
                                              await SharedPreferences
                                                  .getInstance();
                                          pref.clear();
                                          Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginScreen(),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          "LogOut",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(),
                                            backgroundColor: Colors
                                                .red), // Use red for delete action
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              body: _buildItemList()[_selectedIndex],
              bottomNavigationBar: BottomNavigationBar(
                selectedItemColor: greenColor,
                currentIndex: _selectedIndex,
                unselectedItemColor: Colors.black,
                showUnselectedLabels: true,
                type: BottomNavigationBarType.fixed,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.energy_savings_leaf),
                    label: 'All Crops',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.money_dollar_circle_fill),
                    label: 'My Bids',
                  ),
                ],
                onTap: (value) {
                  setState(() {
                    _selectedIndex = value;
                  });
                },
              ),
            ),
    );
  }
}
