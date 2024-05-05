import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parvaah_helping_hand/src/constants/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DisplaySponsorDetailsScreen extends StatefulWidget {
  final DocumentSnapshot sponsor;

  const DisplaySponsorDetailsScreen({Key? key, required this.sponsor})
      : super(key: key);

  @override
  _DisplaySponsorDetailsScreenState createState() =>
      _DisplaySponsorDetailsScreenState();
}

class _DisplaySponsorDetailsScreenState
    extends State<DisplaySponsorDetailsScreen> {
  bool _isAccepted = false;
  bool _isDeclined = false;

  @override
  void initState() {
    super.initState();
    _checkSponsorshipStatus();
  }

  void _checkSponsorshipStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Check if the sponsorship has been accepted or declined
    setState(() {
      _isAccepted = prefs.getBool('${widget.sponsor.id}_accepted') ?? false;
      _isDeclined = prefs.getBool('${widget.sponsor.id}_declined') ?? false;
    });
  }

  void _acceptSponsorship() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Save the acceptance status
    await prefs.setBool('${widget.sponsor.id}_accepted', true);
    // Update UI
    setState(() {
      _isAccepted = true;
      _isDeclined = false;
    });
    // Show snackbar
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Accepted')));
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var brightness = mediaQuery.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDarkMode ? tAccentColor : tDashboardBg,
      appBar: AppBar(
        backgroundColor: isDarkMode ? tPrimaryColor : tBgColor,
        title: const Text(
          'Sponsorship',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                widget.sponsor['image_url'],
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.error),
              ),
              Text(
                'Name: ${widget.sponsor.id}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                'Age: ${widget.sponsor['age']}',
                style: const TextStyle(fontSize: 17),
              ),
              const SizedBox(height: 10),
              Text(
                'Gender: ${widget.sponsor['Gender']}',
                style: const TextStyle(fontSize: 17),
              ),
              const SizedBox(height: 10),
              Text(
                'Address: ${widget.sponsor['address']}',
                style: const TextStyle(fontSize: 17),
              ),
              const SizedBox(height: 10),
              Text(
                'City: ${widget.sponsor['city']}',
                style: const TextStyle(fontSize: 17),
              ),
              const SizedBox(height: 10),
              Text(
                'State: ${widget.sponsor['state']}',
                style: const TextStyle(fontSize: 17),
              ),
              const SizedBox(height: 10),
              Text(
                'Pincode: ${widget.sponsor['pincode']}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Text(
                'Amount: ₹${widget.sponsor['amount']}',
                style: const TextStyle(fontSize: 17),
              ),
              const SizedBox(height: 10),
              Text(
                'Sponsored by: ${widget.sponsor['sponsored_by']}',
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              if (!_isAccepted && !_isDeclined)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: _acceptSponsorship,
                      child: Text('Accept'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text('Declined')));
                        setState(() {
                          _isAccepted = false;
                          _isDeclined = true;
                        });
                      },
                      child: Text('Decline'),
                    ),
                  ],
                ),
              if (_isAccepted || _isDeclined)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    _isAccepted ? 'Accepted' : 'Declined',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: _isAccepted ? Colors.green : Colors.red,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
