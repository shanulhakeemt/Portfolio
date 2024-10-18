import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:shanu/utils/theme.dart';
import 'package:shanu/widgets/bullet.dart';
import 'package:shanu/widgets/responsive_widget.dart';



class RecentTech extends StatelessWidget {
  final String title;
  const RecentTech({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          const Bullet(),
          const SizedBox(width: 15),
          AutoSizeText(
            title,
            style: TextStyles.skill,
            maxFontSize: !ResponsiveWidget.isSmallScreen(context) ? 15.0 : 13.0,
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}
