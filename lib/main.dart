import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shanu/home.dart';
import 'package:shanu/utils/theme.dart';

void main() {
  runApp(const ProviderScope(child: PersonalWebsite()));
}

class PersonalWebsite extends StatelessWidget {
  const PersonalWebsite({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Shanul hakeem | Software Developer",
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.backgroundBlue,
        canvasColor: AppColors.backgroundBlue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Calibre',
      ),
      home: const Home(),
    );
  }
}
