import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:techify/constants/theme.dart';
import 'package:techify/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:techify/firebase_helper/firebase_options/firebase_options.dart';
import 'package:techify/provider/app_provider.dart';
import 'package:techify/screens/custom_bottom_nav_bar/custom_bottom_nav_bar.dart';
import 'package:techify/screens/home/welcome_screen.dart';

void main() async {
  //await Future.delayed(const Duration(seconds: 3));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: MaterialApp(
        title: 'Techify',
        debugShowCheckedModeBanner: false,
        theme: themeData,
        builder: (context, child) => ResponsiveBreakpoints.builder(
          child: child!,
          breakpoints: [
            const Breakpoint(start: 0, end: 450, name: MOBILE),
            const Breakpoint(start: 451, end: 800, name: TABLET),
            const Breakpoint(start: 801, end: 1920, name: DESKTOP),
            const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
          ],
        ),
        home: StreamBuilder(
          stream: FirebaseAuthHelper.instance.getAuthChange,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const CustomBottomNavBar();
            }
            return const WelcomeScreen();
          },
        ),
      ),
    );
  }
}
