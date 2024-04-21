import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:parvaah_helping_hand/src/constants/colors.dart';
import 'package:parvaah_helping_hand/src/features/authentication/screens/contri_dash/drawer.dart';
import 'package:parvaah_helping_hand/src/features/authentication/screens/org_dash/display.dart';
import 'package:parvaah_helping_hand/src/features/authentication/screens/org_dash/getupdates.dart';
import 'package:parvaah_helping_hand/src/features/authentication/screens/org_dash/addupdates.dart';

class OrganizationDashboardScreen extends StatefulWidget {
  const OrganizationDashboardScreen({Key? key}) : super(key: key);
  static String routeName = '/orgdashboard';

  @override
  _OrganizationDashboardScreenState createState() =>
      _OrganizationDashboardScreenState();
}

class _OrganizationDashboardScreenState
    extends State<OrganizationDashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var brightness = mediaQuery.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: isDarkMode ? tAccentColor : tDashboardBg,
      appBar: AppBar(
        backgroundColor: isDarkMode ? tPrimaryColor : tBgColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.menu_open_sharp,
            color: Colors.white,
          ),
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
        ),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      drawer: const DrawerScreen(),
      body: ListView(
        children: [
          SizedBox(
            height: mediaQuery.size.height,
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                OrgDashScreenContent(
                  pageController: _pageController,
                  onJumpToUpdates: _jumpToUpdates,
                ),
                const Getupdates(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Updates()),
          );
        },
        backgroundColor: const Color.fromARGB(255, 244, 243, 243),
        child: const Icon(Icons.add), // Set your preferred button color
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOutQuart,
            );
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.post_add),
            label: 'Posts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.upload),
            label: 'Updates',
          ),
        ],
        backgroundColor: isDarkMode ? tPrimaryColor : Colors.white,
        selectedItemColor: isDarkMode
            ? Colors.amber
            : tPrimaryColor, // Set selected item color
        unselectedItemColor: isDarkMode
            ? Colors.white
            : const Color.fromARGB(
                255, 152, 118, 157), // Set unselected item color
      ),
    );
  }

  void _jumpToUpdates() {
    setState(() {
      _currentIndex = 1; // Index 1 corresponds to DonateScreen
      _pageController.animateToPage(
        1,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutQuart,
      );
    });
  }
}

class OrgDashScreenContent extends StatelessWidget {
  final PageController pageController;
  final VoidCallback onJumpToUpdates;

  const OrgDashScreenContent({
    Key? key,
    required this.pageController,
    required this.onJumpToUpdates,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var brightness = mediaQuery.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: isDarkMode ? tPrimaryColor : tBgColor,
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
            ),
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'PARVAAH',
                      style: TextStyle(
                        color: isDarkMode ? Colors.white : tPrimaryColor,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 0,
                    ),
                    Text(
                      'Organization',
                      style: TextStyle(
                        color: isDarkMode ? Colors.white : tPrimaryColor,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(5),
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
                  height: 10,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection('posts').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }
              return ListView.builder(
                shrinkWrap: true,
                reverse: true,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var post = snapshot
                      .data!.docs[snapshot.data!.docs.length - 1 - index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PostDetailsScreen(post: post),
                        ),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 245, 242, 242),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            post['title'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            post['subtitle'],
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
