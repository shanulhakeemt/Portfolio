import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shanu/data/keys.dart';
import 'package:shanu/data/text.dart';
import 'package:shanu/data/url.dart';
import 'package:shanu/utils/theme.dart';
import 'package:shanu/widgets/fade_animation.dart';
import 'package:shanu/widgets/recent_tech.dart';
import 'package:shanu/widgets/responsive_widget.dart';
import 'package:shanu/widgets/section_title.dart';
import 'package:shanu/widgets/slide_animation.dart';

import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class AboutMe extends StatelessWidget {
   AboutMe({super.key});

  AutoSizeGroup paragraphGroup = AutoSizeGroup();

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        children: <Widget>[
          const SlideAnimation(
            animationKey: Keys.aboutSection,
            delay: Duration(milliseconds: 50),
            child: SectionTitle(
              number: SectionTitleData.sectionNumber1,
              title: SectionTitleData.section1Title,
            ),
          ),
          FadeAnimation(
            animationKey: Keys.aboutMe,
            delay: const Duration(milliseconds: 150),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _aboutMeParagraph1(),
                const SizedBox(height: 25.0),
                _aboutMeParagraph2(),
                const SizedBox(height: 25.0),
                _aboutMeParagraph3(),
                const SizedBox(height: 25.0),
                _recentTech(context)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _aboutMeParagraph1() {
    return AutoSizeText.rich(
      const TextSpan(
        style: TextStyles.paragraph,
        children: <TextSpan>[
          TextSpan(
            text: AboutMeData.paragraph1Part1,
          ),
        ],
      ),
      maxLines: 5,
      group: paragraphGroup,
    );
  }

  Widget _aboutMeParagraph2() {
    return AutoSizeText.rich(
      TextSpan(
        style: TextStyles.paragraph,
        children: <TextSpan>[
          const TextSpan(
            text: AboutMeData.paragraph2Part1,
          ),
          TextSpan(
            text: WorkData.calicut,
            style: TextStyles.highlightParagraph,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                launch(Url.calicut);
              },
          ),
          const TextSpan(
            text: AboutMeData.paragraph2Part2,
          ),
        ],
      ),
      maxLines: 5,
      group: paragraphGroup,
    );
  }

  Widget _aboutMeParagraph3() {
    return AutoSizeText.rich(
      const TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: AboutMeData.paragraph3,
            style: TextStyles.paragraph,
          ),
        ],
      ),
      maxLines: 5,
      group: paragraphGroup,
    );
  }

  // Widget _aboutMeParagraph4() {
  Widget _recentTech(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            RecentTech(title: TechData.flutter),
            RecentTech(title: TechData.firebase),
            RecentTech(title: TechData.cleanArchitecture),
            RecentTech(title: TechData.bloc),
            RecentTech(title: TechData.hive),
          ],
        ),
        SizedBox(
            width: !ResponsiveWidget.isSmallScreen(context) ? 100.0 : 60.0),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            RecentTech(title: TechData.dart),
            RecentTech(title: TechData.riverpod),
            RecentTech(title: TechData.mvc),
            RecentTech(title: TechData.git),
            RecentTech(title: TechData.restapi),
          ],
        ),
      ],
    );
  }
}
