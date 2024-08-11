// import 'package:flutter/material.dart';
//
// class Prediction extends StatelessWidget {
//   Prediction({super.key});
//
//   List<String> items = ['Tomato', 'Potato'];
//
//   @override
//   Widget build(BuildContext context) {
//     File? _imageFile;
//     final TextEditingController _textController = TextEditingController();
//
//     Future<void> _pickImage() async {
//       final picker = ImagePicker();
//       final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//
//       if (pickedFile != null) {
//         setState(() {
//           _imageFile = File(pickedFile.path);
//         });
//       }
//     }
//
//     Future<void> _sendData() async {
//       if (_imageFile == null || _textController.text.isEmpty) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Please provide both text and image')),
//         );
//         return;
//       }
//
//       final dio = Dio();
//       final formData = FormData.fromMap({
//         'stringKey': _textController.text,
//         'imageKey': await MultipartFile.fromFile(
//             _imageFile!.path, filename: 'image.jpg'),
//       });
//
//       try {
//         final response = await dio.post(
//           'https://your-api-endpoint.com/upload',
//           data: formData,
//         );
//
//         if (response.statusCode == 200) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Upload successful!')),
//           );
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text(
//                 'Failed to upload. Status code: ${response.statusCode}')),
//           );
//         }
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error: $e')),
//         );
//       }
//     }
//
//     @override
//     Widget build(BuildContext context) {
//       return Scaffold(
//           appBar: AppBar(
//             title: Text('Upload Image and Text'),
//           ),
//           body: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   TextField(
//                     controller: _textController,
//                     decoration: InputDecoration(
//                       labelText: 'Enter some text',
//                     ),
//                   ),
//                   SizedBox(height: 16.0),
//                   _imageFile == null
//                       ? Text('No image selected.')
//                       : Image.file(_imageFile!),
//                   SizedBox(height: 16.0),
//                   ElevatedButton(
//                     onPressed: _pickImage,
//                     child: Text('Pick Image'),
//                   ),
//                   SizedBox(height: 16.0),
//                   ElevatedButton(
//                     onPressed: _sendData,
//                     child: Text('Send Data'),
//                   ),
//                 ],
//               ),
//                  ),
//           );
//   }
// }

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Prediction extends StatefulWidget {
  const Prediction({super.key});

  @override
  State<Prediction> createState() => _PredictionState();
}

class _PredictionState extends State<Prediction> {
  File? _imageFile;
  final TextEditingController _textController = TextEditingController();

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _sendData() async {
    if (_imageFile == null || _textController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please provide both text and image')),
      );
      return;
    }

    final dio = Dio();
    final formData = FormData.fromMap({
      'stringKey': _textController.text,
      'imageKey': await MultipartFile.fromFile(_imageFile!.path, filename: 'image.jpg'),
    });

    try {
      final response = await dio.post(
        'http://127.0.0.1:5000/predict/tomato',
        data: formData,
      );

      if (response.statusCode == 200) {
        print(response);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Upload successful!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to upload. Status code: ${response.statusCode}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Upload Image and Text'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                  controller: _textController,
                  decoration: InputDecoration(
                    labelText: 'Enter some text',
                  ),
                ),
                SizedBox(height: 16.0),
                _imageFile == null
                    ? Text('No image selected.')
                    : Image.file(_imageFile!),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _pickImage,
                  child: Text('Pick Image'),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _sendData,
                  child: Text('Send Data'),
                ),
              ],
            ),
            ),
        );
    }
}

