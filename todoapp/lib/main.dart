import 'dart:io';  // Import dart:io to use Platform.isWindows
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/homepage.dart';
import 'package:todo_app/utils/dark_mode.dart';

void main() async {
  await Hive.initFlutter();
  var box = await Hive.openBox('mybox');
  WidgetsFlutterBinding.ensureInitialized();

  // Only initialize mobile ads for platforms that support it
  if (Platform.isAndroid || Platform.isIOS) {
    // Uncomment and initialize Google Mobile Ads for Android/iOS
    // MobileAds.instance.initialize();
  }

  // You can also add platform-specific code for other parts of your app if needed
  if (Platform.isWindows) {
    // Code for Windows platform (e.g., using win32 package)
    print("Running on Windows");
    // Add Windows-specific code here
  } else {
    // Code for other platforms (iOS, Android, etc.)
    print("Running on a non-Windows platform");
  }

  runApp(
    ChangeNotifierProvider(
      create: (context) => darkMode(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<darkMode>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomePage(),
          theme: themeProvider.currentTheme, // Apply the theme from Provider
        );
      },
    );
  }
}
