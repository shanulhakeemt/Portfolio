import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shanu/utils/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class ClickableIcon extends ConsumerWidget {
  final IconData icon;
  final double iconSize;
  final Color iconColor;
  final String url;
  ClickableIcon(
      {super.key,
      required this.icon,
      required this.iconSize,
      required this.url,
      this.iconColor = AppColors.lightGrey1});

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
    return MouseRegion(
      onEnter: (event) {
        changeHovering(true, ref);
      },
      onExit: (event) {
        changeHovering(false, ref);
      },
      child: Consumer(builder: (context, ref, child) {
        return IconButton(
          padding: const EdgeInsets.all(0.0),
          constraints: const BoxConstraints(),
          icon: FaIcon(icon),
          iconSize: iconSize,
          color: ref.watch(isHoverProvider) ? AppColors.blueAccent : iconColor,
          onPressed: () => launch(url),
        );
      }),
    );
  }
}
