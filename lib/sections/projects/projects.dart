import 'dart:convert';
import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shanu/data/keys.dart';
import 'package:shanu/data/text.dart';
import 'package:shanu/utils/theme.dart';
import 'package:shanu/widgets/fade_animation.dart';
import 'package:shanu/widgets/project.dart';
import 'package:shanu/widgets/responsive_widget.dart';
import 'package:shanu/widgets/section_title.dart';
import 'package:shanu/widgets/slide_animation.dart';

final isChangeListProvider = StateProvider<bool>(
  (ref) => false,
);

class Projects extends ConsumerStatefulWidget {
  const Projects({super.key});

  @override
  ConsumerState<Projects> createState() => _ProjectsState();
}

class _ProjectsState extends ConsumerState<Projects> {
  final options = const LiveOptions(
    delay: Duration(milliseconds: 200),
    showItemInterval: Duration(milliseconds: 100),
    showItemDuration: Duration(milliseconds: 300),
  );

  void changeBool(bool isChange, WidgetRef ref) {
    ref.read(isChangeListProvider.notifier).update(
          (state) => isChange,
        );
  }

  @override
  Widget build(BuildContext context) {
    bool isSmallScreen = ResponsiveWidget.isSmallScreen(context);
    bool isMediumScreen = ResponsiveWidget.isMediumScreen(context);

    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SlideAnimation(
            animationKey: Keys.projectsSection,
            delay: Duration(milliseconds: 50),
            child: SectionTitle(
              number: SectionTitleData.sectionNumber3,
              title: SectionTitleData.section3Title,
            ),
          ),
          Consumer(builder: (context, ref, child) {
            return LiveGrid.options(
              options: options,
              primary: true,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: ref.watch(isChangeListProvider)
                  ? ref.watch(getProjectsNotifierProvider).length
                  : ref.watch(getProjectsNotifierProvider).length < 2
                      ? 0
                      : 3,
              itemBuilder: (BuildContext context, int index,
                  Animation<double> animation) {
                final projects = ref.watch(getProjectsNotifierProvider);
                return FadeTransition(
                  opacity: Tween<double>(
                    begin: 0,
                    end: 1,
                  ).animate(CurvedAnimation(
                      parent: animation, curve: Curves.easeOut)),
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, -0.2),
                      end: Offset.zero,
                    ).animate(animation),
                    child: Project(
                      title: projects[index]['title'],
                      description: projects[index]['description'],
                      url: projects[index]['url'],
                      tags: projects[index]['tags'],
                    ),
                  ),
                );
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isSmallScreen
                    ? 1
                    : isMediumScreen
                        ? 2
                        : 3,
                childAspectRatio: 1.35 / 1.25,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
              ),
            );
          }),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 48.0),
            child: Center(
              child: FadeAnimation(
                animationKey: Keys.projectsButton,
                delay: const Duration(milliseconds: 50),
                child: Consumer(builder: (context, ref, child) {
                  return OutlinedButton(
                    style: ButtonStyles.primary,
                    child: Text(
                      ref.watch(isChangeListProvider)
                          ? ButtonData.showLess
                          : ButtonData.showMore,
                      style: TextStyles.buttonText,
                    ),
                    onPressed: () {
                      ref.read(isChangeListProvider.notifier).update(
                            (state) => !state,
                          );
                    },
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        getJsonData();
      },
    );
  }

  Future<void> getJsonData() async {
    final String jsonData =
        await rootBundle.loadString('assets/project_data1.json');
    final data = await jsonDecode(jsonData);
    ref
        .read(getProjectsNotifierProvider.notifier)
        .initialUpdateList(data["projects"]);
  }
}

final getProjectsNotifierProvider = NotifierProvider<GetProjectsNotifier, List>(
  () => GetProjectsNotifier(),
);

class GetProjectsNotifier extends Notifier<List> {
  void initialUpdateList(List list) {
    state = list;
  }

  @override
  List build() {
    return [];
  }
}
