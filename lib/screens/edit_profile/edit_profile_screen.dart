// ignore_for_file: avoid_print, prefer_const_constructors

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String _name = '';
  String _email = '';
  String _bio = '';
  File? _image;

  final ImagePicker _imagePicker = ImagePicker();

  void _selectImage() async {
    final pickedImage =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
      }
    });
  }

  void _saveChanges() {
    // Add code to save changes to the user's profile
    // e.g., make an API request, update local database, etc.
    // You can replace this with your own implementation.
    print('Name: $_name');
    print('Email: $_email');
    print('Bio: $_bio');
    if (_image != null) {
      // Process and upload the selected image
      print('Profile Image: ${_image!.path}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        elevation: 0,
        title: const Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap: _selectImage,
              child: CircleAvatar(
                radius: 60.0,
                backgroundImage: _image != null ? FileImage(_image!) : null,
                child:
                    _image == null ? Icon(Icons.camera_alt, size: 40.0) : null,
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              initialValue: _name,
              decoration: InputDecoration(labelText: 'Name'),
              onChanged: (value) {
                setState(() {
                  _name = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              initialValue: _email,
              decoration: InputDecoration(labelText: 'Email'),
              onChanged: (value) {
                setState(() {
                  _email = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              initialValue: _bio,
              decoration: InputDecoration(
                labelText: 'Bio',
              ),
              onChanged: (value) {
                setState(() {
                  _bio = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            TextButton(
              style: TextButton.styleFrom(
                minimumSize: Size(double.infinity, 40),
                foregroundColor: Colors.white,
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                // save changes to firebase
                // back to account screen
              },
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Save',
                  style: TextStyle(fontSize: 19),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
