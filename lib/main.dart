import 'package:flutter/material.dart';
import 'package:switch_theme_app/services/theme_service.dart';
import 'package:switch_theme_app/views/home_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: colorMode,
      builder: (BuildContext context, dynamic colormodevalue, Widget? child) {
        return ValueListenableBuilder(
          valueListenable: themeMode,
          builder: (context, themeModeValue, child) {
            return MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(
                  seedColor: colormodevalue,
                  brightness: themeModeValue == 'dark'
                      ? Brightness.dark
                      : Brightness.light,
                ),
              ),
              home: HomeView(title: 'Switch Theme: $themeModeValue'),
            );
          },
        );
      },
    );
  }
}
