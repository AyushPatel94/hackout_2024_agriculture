import 'dart:convert';
import 'package:abcd/Home_screenFarmer.dart';
import 'package:abcd/Home_screen_buyer.dart';
import 'package:abcd/RegistrationScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 40.0),
              child: Column(
                children: [
                  Image.network(
                    "https://i.imgur.com/1QE0xzq.png",
                    height: screenHeight * 0.2,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Welcome back',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: screenWidth,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    // Tab Bar
                    TabBar(
                      labelColor: Colors.green[700],
                      unselectedLabelColor: Colors.green[200],
                      indicatorColor: Colors.green[700],
                      tabs: [
                        Tab(text: 'Farmer Login'),
                        Tab(text: 'Buyer Login'),
                      ],
                    ),
                    SizedBox(height: 20),
                    // Tab Bar View
                    Container(
                      height: screenHeight * 0.4,
                      child: TabBarView(
                        children: [
                          FormScreenFarmer(),
                          FormScreenBuyer(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => RegistrationScreen(),
                  ),
                );
              },
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have account?"),
                    Text(
                      " Register Now.",
                      style: TextStyle(
                        color: Colors.green.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class FormScreenFarmer extends StatefulWidget {
  @override
  _FormScreenFarmerState createState() => _FormScreenFarmerState();
}

class _FormScreenFarmerState extends State<FormScreenFarmer> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  String? _phoneErrorText;
  String? _passwordErrorText;

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _onLoginPressed() async {
    if (_formkey.currentState!.validate()) {
      String phoneNumber = _phoneController.text.trim();
      String password = _passwordController.text.trim();

      try {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('users')
            .where('phoneNo', isEqualTo: phoneNumber)
            .where('password', isEqualTo: password)
            .where('userType', isEqualTo: "Farmer")
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          setState(() {
            _phoneErrorText = null;
            _passwordErrorText = null;
          });
          Map<String, dynamic> document =
              querySnapshot.docs[0].data() as Map<String, dynamic>;
          SharedPreferences pref = await SharedPreferences.getInstance();
          await pref.setBool("IsLogedIn", true);
          await pref.setBool("IsBuyer", false);
          Map<String, dynamic> data = {
            "userName": document["userName"],
            "phoneNo": document["phoneNo"],
            "userType": document["userType"],
            "userID":document["userType"]+document["phoneNo"]
          };
          await pref.setString("user", jsonEncode(data));
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => HomeScreenFarmer(),
            ),
          );
        } else {
          setState(() {
            _phoneErrorText = 'Invalid phone number or password';
            _passwordErrorText = 'Invalid phone number or password';
          });
        }
      } catch (e) {
        print('Error: $e');
        setState(() {
          _phoneErrorText = 'An error occurred. Please try again.';
          _passwordErrorText = 'An error occurred. Please try again.';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _formkey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _phoneController,
              decoration: InputDecoration(
                hintText: 'Phone Number',
                hintStyle: TextStyle(color: Colors.grey[600]),
                prefixIcon: Icon(Icons.phone, color: Colors.green[700]),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: _phoneErrorText != null
                        ? Colors.red
                        : Colors.green.shade700,
                    width: 2,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: _phoneErrorText != null
                        ? Colors.red
                        : Colors.green.shade700,
                    width: 2,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.red,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.black,
                  ),
                ),
                errorText: _phoneErrorText,
              ),
              keyboardType: TextInputType.phone,
              validator: (value) {
                String pattern = r'(^[0-9]{10}$)';
                RegExp regExp = RegExp(pattern);
                if (value!.isEmpty) {
                  return 'Please enter mobile number';
                } else if (!regExp.hasMatch(value)) {
                  return 'Please enter a valid mobile number';
                }
                return null;
              },
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                hintText: 'Password',
                hintStyle: TextStyle(color: Colors.grey[600]),
                prefixIcon: Icon(Icons.lock, color: Colors.green[700]),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.green[700],
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: _passwordErrorText != null
                        ? Colors.red
                        : Colors.green.shade700,
                    width: 2,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: _passwordErrorText != null
                        ? Colors.red
                        : Colors.green.shade700,
                    width: 2,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.red,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.black,
                  ),
                ),
                errorText: _passwordErrorText,
              ),
              obscureText: !_isPasswordVisible,
              validator: (value) {
                if (value!.length < 8) {
                  return "Password length should be greater than 8";
                }
                return null;
              },
            ),
            SizedBox(height: 40.0),
            MaterialButton(
              onPressed: () async {
                _onLoginPressed();
              },
              child: Text(
                'LogIn',
                style: TextStyle(
                  letterSpacing: 1.4,
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
              color: Colors.green.shade700,
              disabledColor: Colors.green[300],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.symmetric(vertical: 15.0),
              minWidth: double.infinity,
            ),
          ],
        ),
      ),
    );
  }
}

class FormScreenBuyer extends StatefulWidget {
  @override
  _FormScreenBuyerState createState() => _FormScreenBuyerState();
}

class _FormScreenBuyerState extends State<FormScreenBuyer> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _phoneErrorText;
  String? _passwordErrorText;

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _onLoginPressed() async {
    if (_formKey.currentState!.validate()) {
      String phoneNumber = _phoneController.text.trim();
      String password = _passwordController.text.trim();

      try {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('users') // Replace with your collection name
            .where('phoneNo', isEqualTo: phoneNumber)
            .where('password', isEqualTo: password)
            .where('userType', isEqualTo: "Buyer")
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          setState(() {
            _phoneErrorText = null;
            _passwordErrorText = null;
          });
          Map<String, dynamic> document =
          querySnapshot.docs[0].data() as Map<String, dynamic>;
          SharedPreferences pref = await SharedPreferences.getInstance();
          await pref.setBool("IsLogedIn", true);
          await pref.setBool("IsBuyer", true);
          Map<String, dynamic> data = {
            "userName": document["userName"],
            "phoneNo": document["phoneNo"],
            "userType": document["userType"],
            "userID":document["userType"]+document["phoneNo"]
          };
          await pref.setString("user", jsonEncode(data));
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => HomeScreenBuyer(),
            ),
          );
        } else {
          setState(() {
            _phoneErrorText = 'Invalid phone number or password';
            _passwordErrorText = 'Invalid phone number or password';
          });
        }
      } catch (e) {
        print('Error: $e');
        setState(() {
          _phoneErrorText = 'An error occurred. Please try again.';
          _passwordErrorText = 'An error occurred. Please try again.';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                  hintText: 'Phone Number',
                  hintStyle: TextStyle(color: Colors.grey[600]),
                  prefixIcon: Icon(Icons.phone, color: Colors.green[700]),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: _phoneErrorText != null
                          ? Colors.red
                          : Colors.green.shade700,
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: _phoneErrorText != null
                          ? Colors.red
                          : Colors.green.shade700,
                      width: 2,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.red,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  errorText: _phoneErrorText,
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  String pattern = r'(^[0-9]{10}$)';
                  RegExp regExp = RegExp(pattern);
                  if (value!.isEmpty) {
                    return 'Please enter mobile number';
                  } else if (!regExp.hasMatch(value)) {
                    return 'Please enter a valid mobile number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  hintText: 'Password',
                  hintStyle: TextStyle(color: Colors.grey[600]),
                  prefixIcon: Icon(Icons.lock, color: Colors.green[700]),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.green[700],
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: _passwordErrorText != null
                          ? Colors.red
                          : Colors.green.shade700,
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: _passwordErrorText != null
                          ? Colors.red
                          : Colors.green.shade700,
                      width: 2,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.red,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  errorText: _passwordErrorText,
                ),
                obscureText: !_isPasswordVisible,
                validator: (value) {
                  if (value!.length < 8) {
                    return "Password length should be greater than 8";
                  }
                  return null;
                },
              ),
              SizedBox(height: 40.0),
              MaterialButton(
                onPressed: () {
                  _onLoginPressed();
                },
                child: Text(
                  'LogIn',
                  style: TextStyle(
                    letterSpacing: 1.4,
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                ),
                color: Colors.green[700],
                disabledColor: Colors.green[300],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(vertical: 15.0),
                minWidth: double.infinity,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
