import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parvaah_helping_hand/src/constants/colors.dart';

class SponsorPersonScreen extends StatefulWidget {
  const SponsorPersonScreen({Key? key}) : super(key: key);

  @override
  _SponsorPersonScreenState createState() => _SponsorPersonScreenState();
}

class _SponsorPersonScreenState extends State<SponsorPersonScreen> {
  File? _imageFile; // Store the selected image file

  // Add controllers for the form fields
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  List<String> selectedSex = []; // List to store selected sexes
  TextEditingController locationController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var brightness = mediaQuery.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDarkMode ? tAccentColor : tDashboardBg,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
        child: _CustomSponsorAppBar(isDarkMode: isDarkMode),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                // Open bottom sheet to choose between camera and gallery
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
            const SizedBox(height: 40),
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
                    controller: locationController,
                    decoration: const InputDecoration(
                      hintText: 'Enter address',
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'City',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  TextField(
                    controller: areaController,
                    decoration: const InputDecoration(
                      hintText: 'Enter city',
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'State',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  TextField(
                    controller: pincodeController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Enter state',
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Pincode',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  TextField(
                    controller: pincodeController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Enter pincode',
                    ),
                  ),
                  const SizedBox(height: 40),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text(
                        'Sponsor',
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
}

class _CustomSponsorAppBar extends StatelessWidget {
  final bool isDarkMode;
  const _CustomSponsorAppBar({Key? key, required this.isDarkMode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isDarkMode
            ? tPrimaryColor
            : tBgColor, // Change color as needed for SponsorPersonScreen
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppBar(
            backgroundColor: Colors.transparent,
            leadingWidth: 28,
            toolbarHeight: 70,
            elevation: 0,
            title: const Column(
              children: [
                Text(
                  'Sponsor a Person',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
            systemOverlayStyle: SystemUiOverlayStyle.dark,
          ),
        ],
      ),
    );
  }
}
