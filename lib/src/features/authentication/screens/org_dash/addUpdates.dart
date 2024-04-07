import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parvaah_helping_hand/src/constants/colors.dart';
import 'package:parvaah_helping_hand/src/features/authentication/screens/org_dash/dashboard2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable, camel_case_types
class Updates extends StatefulWidget {
  Updates({Key? key}) : super(key: key);

  @override
  _UpdatesState createState() => _UpdatesState();
}

class _UpdatesState extends State<Updates> {
  TextEditingController titleController = TextEditingController();
  TextEditingController subtitleController = TextEditingController();
  TextEditingController causeDetailsController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController dateController =
      TextEditingController(); // Controller for the selected date

  CollectionReference ref = FirebaseFirestore.instance.collection('posts');
  File? _imageFile;
  late Uint8List _imageBytes;

  void _showImageSourceOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Take a photo'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.image),
                title: const Text('Choose from gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        _imageBytes = _imageFile!.readAsBytesSync();
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        // Format the picked date as needed
        dateController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  Future<void> _uploadData() async {
    if (_imageBytes.isNotEmpty) {
      // Upload image to Firebase Storage
      final Reference storageRef = FirebaseStorage.instance
          .ref()
          .child('images')
          .child('${DateTime.now()}.png');
      await storageRef.putData(_imageBytes);

      // Get download URL for the uploaded image
      final String downloadURL = await storageRef.getDownloadURL();

      // Save data to Firestore after obtaining download URL
      await ref.add({
        'title': titleController.text,
        'subtitle': subtitleController.text,
        'causeDetails': causeDetailsController.text,
        'amountNeeded': amountController.text,
        'date': dateController.text,
        'imageURL': downloadURL, // Add the image download URL to Firestore
      });
    } else {
      // Handle case when no image is selected
    }
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var brightness = mediaQuery.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDarkMode ? tAccentColor : tDashboardBg,
      appBar: AppBar(
        title: const Text("Upload an Event"),
        backgroundColor: isDarkMode ? tPrimaryColor : tBgColor,
        actions: [
          MaterialButton(
            onPressed: () async {
              await _uploadData(); // Call _uploadData to get download URL
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const OrganizationDashboardScreen(),
                ),
              );
            },
            child: const Text(
              "Save",
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                    labelText: 'Title',
                    labelStyle:
                        TextStyle(color: Color.fromARGB(255, 40, 35, 35))),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: subtitleController,
                decoration: const InputDecoration(
                    labelText: 'Subtitle',
                    labelStyle:
                        TextStyle(color: Color.fromARGB(255, 40, 35, 35))),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: causeDetailsController,
                decoration: const InputDecoration(
                    labelText: 'Cause Details',
                    labelStyle:
                        TextStyle(color: Color.fromARGB(255, 40, 35, 35))),
                maxLines: null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: amountController,
                decoration: const InputDecoration(
                    labelText: 'To Collect',
                    labelStyle:
                        TextStyle(color: Color.fromARGB(255, 40, 35, 35))),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () => _selectDate(context), // Open date picker on tap
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: dateController,
                    decoration: const InputDecoration(
                      labelText: 'Date',
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 40, 35, 35)),
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () => _showImageSourceOptions(context),
                child: const Text('Upload Image / GIF'),
              ),
              const SizedBox(height: 10),
              if (_imageFile != null) ...[
                Image.file(_imageFile!),
                const SizedBox(height: 10),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
