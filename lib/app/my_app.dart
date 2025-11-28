import 'package:flutter/material.dart';
import 'package:thancoder_pre_app/app/ui/home/home_screen.dart';
import 'package:thancoder_pre_app/more_libs/setting/core/theme_listener.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeListener(
      builder: (context, themeMode) => MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: themeMode,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        home: HomeScreen(),
      ),
    );
  }
}
