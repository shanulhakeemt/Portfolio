import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shanu/utils/theme.dart';
import 'package:shanu/widgets/clickable_icon.dart';

import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class Project extends ConsumerWidget {
  final String title;
  final String description;
  final String url;
  final List tags;

  Project({
    super.key,
    required this.title,
    required this.description,
    required this.url,
    required this.tags,
  });

  final isHoverProvider = StateProvider<bool>(
    (ref) => false,
  );

  void changeHovering(bool isHovered, WidgetRef ref) {
    ref.read(isHoverProvider.notifier).update(
          (state) => isHovered,
        );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final frameHovered = Matrix4.identity()..scale(1.035);

    return MouseRegion(
      onEnter: (_) => changeHovering(true, ref),
      onExit: (_) => changeHovering(false, ref),
      cursor:
          _containsUrl() ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: Consumer(builder: (context, ref, child) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 225),
          transformAlignment: Alignment.center,
          transform:
              ref.watch(isHoverProvider) ? frameHovered : Matrix4.identity(),
          child: GestureDetector(
            onTap: () => _containsUrl() ? launch(url) : {},
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0)),
              color: AppColors.blueOffset,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _titleAndGithub(ref.watch(isHoverProvider)),
                          const SizedBox(height: 12.0),
                          _description(),
                        ],
                      ),
                    ),
                    _tags(),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  bool _containsUrl() {
    return url != "";
  }

  Widget _description() {
    return Flexible(
      child: AutoSizeText(
        description,
        style: TextStyles.project,
        maxLines: 5,
      ),
    );
  }

  Widget _tags() {
    return Flexible(
      child: Row(
        children: [
          for (var tag in tags)
            Row(
              children: [
                AutoSizeText(
                  tag,
                  style: TextStyles.projectSkill,
                ),
                const SizedBox(width: 16.0),
              ],
            ),
        ],
      ),
    );
  }

  Widget _titleAndGithub(bool isHovered) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Flexible(
          child: AutoSizeText(
            title,
            style: TextStyles.projectTitle.copyWith(
                color: isHovered ? AppColors.blueAccent : AppColors.lightGrey2),
            maxLines: 2,
          ),
        ),
        if (_containsUrl())
          ClickableIcon(
            icon: FontAwesomeIcons.github,
            iconSize: 20.0,
            iconColor: AppColors.mediumGrey1,
            url: url,
          ),
      ],
    );
  }
}
