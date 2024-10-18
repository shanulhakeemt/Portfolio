import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shanu/utils/theme.dart';
import 'package:shanu/widgets/responsive_widget.dart';

class MyPicture extends ConsumerWidget {
  MyPicture({super.key});

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
    double width = MediaQuery.of(context).size.width;

    final frameHovered = Matrix4.identity()..translate(-6, -12, 0);

    final pictureHovered = Matrix4.identity()..translate(-2, -4, 0);

    const duration = Duration(milliseconds: 300);

    return Padding(
      padding: EdgeInsets.only(
          top: ResponsiveWidget.isAtLeastLargeScreen(context) ? 32.0 : 80.0),
      child: MouseRegion(
        onEnter: (_) => changeHovering(true, ref),
        onExit: (_) => changeHovering(false, ref),
        child: Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            Consumer(builder: (context, ref, child) {
              return AnimatedContainer(
                duration: duration,
                transform: ref.watch(isHoverProvider)
                    ? frameHovered
                    : Matrix4.identity(),
                child: Container(
                  height: ResponsiveWidget.isLargeScreen(context)
                      ? width / 5.5
                      : width / 1.75,
                  width: ResponsiveWidget.isLargeScreen(context)
                      ? width / 7.25
                      : width / 2.25,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.blueAccent, width: 3.0),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              );
            }),
            Positioned(
              top: -20,
              bottom: 20,
              right: 20,
              child: AnimatedContainer(
                duration: duration,
                transform: ref.watch(isHoverProvider)
                    ? pictureHovered
                    : Matrix4.identity(),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.asset(
                    'assets/profile.png',
                    scale: 1,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
