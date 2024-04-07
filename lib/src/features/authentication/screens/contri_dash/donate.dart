import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:parvaah_helping_hand/src/constants/colors.dart';
import 'package:parvaah_helping_hand/src/constants/image_string.dart';
import 'package:parvaah_helping_hand/src/features/authentication/screens/contri_dash/donation_dashboard/education.dart';
import 'package:parvaah_helping_hand/src/features/authentication/screens/contri_dash/donation_dashboard/food.dart';
import 'package:parvaah_helping_hand/src/features/authentication/screens/contri_dash/donation_dashboard/recovery.dart';
import 'package:parvaah_helping_hand/src/features/authentication/screens/contri_dash/donation_dashboard/shelter.dart';

class DonateScreen extends StatelessWidget {
  const DonateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var brightness = mediaQuery.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? tAccentColor : tDashboardBg,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(150), // Set the preferred height
        child: _CustomAppBar(isDarkMode: isDarkMode),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: ListView(
          padding: const EdgeInsets.only(
              top: 35.0), // Adjust the top padding as needed
          children: [
            _EmergencyCauseItem(
              image: tEdu2,
              label: 'Building Dreams through Education',
              isDarkMode: true,
              onTap: () {
                // Navigate to the corresponding screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EducationScreen()),
                );
              },
            ),
            _EmergencyCauseItem(
              image: tRecov1,
              label: 'Turning Disaster into Determination',
              isDarkMode: true,
              onTap: () {
                // Navigate to the corresponding screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RecoveryScreen()),
                );
              },
            ),
            _EmergencyCauseItem(
              image: tHome,
              label: 'From Despair to "Home" ',
              isDarkMode: true,
              onTap: () {
                // Navigate to the corresponding screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ShelterScreen()),
                );
              },
            ),
            _EmergencyCauseItem(
              image: tFood1,
              label: 'Fighting Hunger, Feeding Souls',
              isDarkMode: true,
              onTap: () {
                // Navigate to the corresponding screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FoodScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  final bool isDarkMode;

  const _CustomAppBar({Key? key, required this.isDarkMode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? tPrimaryColor : tBgColor,
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(20), // Adjust the radius as needed
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppBar(
            backgroundColor: Colors.transparent,
            leadingWidth: 28,
            toolbarHeight: 150,
            elevation: 0,
            title: Column(
              children: [
                const Text(
                  'Donate for Help',
                  style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  padding: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 236, 233, 233),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.black87,
                      ),
                      hintText: "Search",
                      hintStyle: TextStyle(
                        color: Colors.black87,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
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

class _EmergencyCauseItem extends StatelessWidget {
  final String image;
  final String label;
  final bool isDarkMode;
  final VoidCallback onTap;

  const _EmergencyCauseItem({
    required this.image,
    required this.label,
    required this.isDarkMode,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: SizedBox(
            width: 40.0,
            height: 40.0,
            child: Image.asset(
              image,
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text(
          label,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
        trailing: _PopupMenuButton(onTap: onTap),
      ),
    );
  }
}

class _PopupMenuButton extends StatelessWidget {
  final VoidCallback onTap;

  const _PopupMenuButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (value) {
        // Handle the selected option
        if (value == 'view') {
          // Call the onTap function passed from _EmergencyCauseItem
          onTap();
        } else if (value == 'share') {
          // Handle share action
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'view',
          child: ListTile(
            leading: Icon(Icons.visibility),
            title: Text('View'),
          ),
        ),
        const PopupMenuItem<String>(
          value: 'share',
          child: ListTile(
            leading: Icon(Icons.share),
            title: Text('Share'),
          ),
        ),
      ],
    );
  }
}
