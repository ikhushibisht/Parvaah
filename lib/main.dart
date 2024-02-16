import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:parvaah_helping_hand/firebase_options.dart';
import 'package:parvaah_helping_hand/src/features/authentication/screens/splash_screen/splash_screen.dart';
import 'package:parvaah_helping_hand/src/utils/theme/theme.dart';
import 'package:parvaah_helping_hand/src/features/authentication/screens/login/login_form.dart';
import 'package:parvaah_helping_hand/src/features/authentication/screens/dashboard/dashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 600),
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: SplashScreen.routeName,
      getPages: [
        GetPage(name: SplashScreen.routeName, page: () => const SplashScreen()),
        GetPage(name: LoginForm.routeName, page: () => const LoginForm()),
        GetPage(
            name: DashboardScreen.routeName,
            page: () => const DashboardScreen()),
        // Add more pages/routes as needed
      ],
    );
  }
}
