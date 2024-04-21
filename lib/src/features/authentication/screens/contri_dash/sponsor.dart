import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:parvaah_helping_hand/src/constants/colors.dart';

class SponsorPersonScreen extends StatefulWidget {
  const SponsorPersonScreen({Key? key}) : super(key: key);

  @override
  _SponsorPersonScreenState createState() => _SponsorPersonScreenState();
}

class _SponsorPersonScreenState extends State<SponsorPersonScreen> {
  File? _imageFile; // Store the selected image file
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Add controllers for the form fields
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController pinController = TextEditingController();
  List<String> selectedSex = [];

  // Variables to store CSCPicker values
  String? selectedCity;
  String? selectedState;
  String? selectedPinCode;

  final _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var brightness = mediaQuery.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDarkMode ? tAccentColor : tDashboardBg,
      appBar: AppBar(
        title: Text(
          'Sponsor a Person',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : tPrimaryColor,
          ),
        ),
        backgroundColor: isDarkMode ? tPrimaryColor : tBgColor,
      ),
      body: Container(
        height: mediaQuery.size.height,
        color: isDarkMode ? tAccentColor : tDashboardBg,
        child: SingleChildScrollView(
          child: Container(
            color: isDarkMode
                ? tAccentColor
                : tDashboardBg, // Set the background color
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min, // Set mainAxisSize to min
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return SafeArea(
                            child: Wrap(
                              children: <Widget>[
                                ListTile(
                                  leading: const Icon(Icons.photo_camera),
                                  title: const Text('Take a Photo'),
                                  onTap: () {
                                    _getImage(ImageSource.camera);
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  leading: const Icon(Icons.photo_library),
                                  title: const Text('Choose from Gallery'),
                                  onTap: () {
                                    _getImage(ImageSource.gallery);
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: CircleAvatar(
                      radius: 75,
                      backgroundColor: Colors.grey,
                      backgroundImage: _imageFile != null
                          ? FileImage(_imageFile!)
                          : null, // Show selected image if available
                      child: _imageFile == null
                          ? const Icon(
                              Icons.camera_alt,
                              size: 65,
                              color: Colors.white,
                            )
                          : null,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Name',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        TextField(
                          controller: nameController,
                          decoration: const InputDecoration(
                            hintText: 'Enter name',
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Age',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        TextField(
                          controller: ageController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            hintText: 'Enter age',
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Sex',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        // Circular checkboxes for Sex selection
                        Row(
                          children: [
                            buildCircularCheckbox('Male', isDarkMode),
                            buildCircularCheckbox('Female', isDarkMode),
                            buildCircularCheckbox('Other', isDarkMode),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Address',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        TextField(
                          controller: addressController,
                          onChanged: (value) {},
                          decoration: const InputDecoration(
                            hintText: 'Enter address',
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          '-Select-',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        CSCPicker(
                          onCountryChanged: (value) {
                            setState(() {
                              selectedState = null;
                              selectedCity = null;
                            });
                          },
                          onStateChanged: (value) {
                            setState(() {
                              selectedState = value;
                              selectedCity = null;
                            });
                          },
                          onCityChanged: (value) {
                            setState(() {
                              selectedCity = value;
                            });
                          },
                          flagState: CountryFlag.DISABLE,
                          dropdownDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            border: Border.all(color: Colors.grey),
                          ),
                          selectedItemStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                          dropdownHeadingStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Pincode',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        TextField(
                          controller: pinController,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {},
                          decoration: const InputDecoration(
                            hintText: 'Enter pincode',
                          ),
                        ),
                        const SizedBox(height: 40),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              _uploadSponsorDetails();
                            },
                            child: const Text(
                              'SPONSOR',
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCircularCheckbox(String sex, bool isDarkMode) {
    return Row(
      children: [
        Checkbox(
          value: selectedSex.contains(sex),
          onChanged: (bool? value) {
            setState(() {
              if (value != null && value) {
                selectedSex.add(sex);
              } else {
                selectedSex.remove(sex);
              }
            });
          },
        ),
        Text(
          sex,
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ],
    );
  }

  // Method to get image from camera or gallery
  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadSponsorDetails() async {
    try {
      // Upload image to Firebase Storage
      if (_imageFile != null) {
        final Reference storageReference = _storage
            .ref()
            .child('sponsor_images/${DateTime.now().millisecondsSinceEpoch}');
        await storageReference.putFile(_imageFile!);
        final String imageUrl = await storageReference.getDownloadURL();

        // Fetch the name of the user who is sponsoring from Firestore
        String sponsorName = await _fetchSponsorName();

        // Update sponsor details in Firestore
        await _firestore.collection('sponsors').add({
          'name': nameController.text,
          'age': int.parse(ageController.text),
          'sex': selectedSex.join(','),
          'address': addressController.text,
          'city': selectedCity,
          'state': selectedState,
          'pincode': pinController.text,
          'image_url': imageUrl,
          'sponsored_by': sponsorName, // Add sponsored by field
          'timestamp': FieldValue.serverTimestamp(),
        });

        // Clear form fields after successful upload
        nameController.clear();
        ageController.clear();
        addressController.clear();
        pinController.clear();
        selectedSex.clear();
        selectedCity = null;
        selectedState = null;
        selectedPinCode = null;
        _imageFile = null;

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Sponsor details uploaded successfully.'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        // Show error message if image is not selected
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select an image.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (error) {
      // Show error message if any error occurs during upload
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred: $error'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<String> _fetchSponsorName() async {
    // Assuming you have a user authentication system, and the user is logged in.
    // Fetch the currently logged-in user's name from the "users" collection in Firestore.
    // You need to replace 'currentUserId' with the actual ID of the logged-in user.
    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .get();
    if (userSnapshot.exists) {
      // Cast the return value of userSnapshot.data() to Map<String, dynamic>
      Map<String, dynamic>? userData =
          userSnapshot.data() as Map<String, dynamic>?;

      // Access the 'fullName' field from the userData map
      String fullName = userData?['fullName'] ?? 'Unknown';

      return fullName;
    } else {
      // Return a default value or handle the case when user data is not found
      return 'Unknown';
    }
  }
}
