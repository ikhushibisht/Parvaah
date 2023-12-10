import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:parvaah_helping_hand/src/constants/colors.dart';
import 'package:parvaah_helping_hand/src/constants/image_string.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var brightness = mediaQuery.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDarkMode ? tAccentColor : tSecondaryColor,
      appBar: AppBar(
        backgroundColor: isDarkMode ? tPrimaryColor : tBgColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.menu_open_sharp,
            color: isDarkMode ? Colors.black87 : Colors.white,
          ),
          onPressed: () {},
        ),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: isDarkMode ? tPrimaryColor : tBgColor,
                    borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(30))),
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'PARVAAH',
                      style: TextStyle(
                          color: isDarkMode ? Colors.white : tPrimaryColor,
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      ' A Helping Hand',
                      style: TextStyle(
                          color: isDarkMode ? Colors.yellow : Colors.black87,
                          fontStyle: FontStyle.italic,
                          fontSize: 19,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: isDarkMode
                              ? const Color.fromARGB(255, 200, 196, 196)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: const TextField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.black87,
                            ),
                            hintText: "Search",
                            hintStyle:
                                TextStyle(color: Colors.black87, fontSize: 15)),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Support Mission',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: 200,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          promoCard(tDash1),
                          promoCard(tDash2),
                          promoCard(tDash3),
                          promoCard(tDash4),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: const DecorationImage(
                            fit: BoxFit.cover, image: AssetImage(tDash4)),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                              begin: Alignment.bottomRight,
                              stops: const [
                                0.3,
                                0.9
                              ],
                              colors: [
                                Colors.black.withOpacity(.8),
                                Colors.black.withOpacity(.2)
                              ]),
                        ),
                        child: const Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Text(
                              'Charity',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget promoCard(image) {
    return AspectRatio(
      aspectRatio: 2.62 / 3,
      child: Container(
        margin: const EdgeInsets.only(right: 15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(fit: BoxFit.cover, image: AssetImage(image)),
        ),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                  begin: Alignment.bottomRight,
                  stops: const [
                    0.1,
                    0.9
                  ],
                  colors: [
                    Colors.black.withOpacity(.8),
                    Colors.black.withOpacity(.1)
                  ])),
        ),
      ),
    );
  }
}
