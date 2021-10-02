import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tesla_monitor/constants.dart';
import 'package:tesla_monitor/home_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final HomeController _controller = HomeController();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      // Rebuild widget when any changes are applied to the controller
      animation: _controller,
      builder: (context, _) {
        return Scaffold(
          body: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: constraints.maxHeight * 0.1,
                      ),
                      child: SvgPicture.asset(
                        "assets/icons/Car.svg",
                        width: double.infinity,
                      ),
                    ),
                    rightDoorLock(constraints),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget rightDoorLock(dynamic constraints) {
    return Positioned(
      right: constraints.maxWidth * 0.05,
      // Animate the lock when clicking
      child: GestureDetector(
        onTap: _controller.updateRightDoorLock,
        child: AnimatedSwitcher(
          duration: defaultDuration,
          switchInCurve: Curves.easeInOutBack,
          // Scale transition when switching image
          transitionBuilder: (child, animation) => ScaleTransition(
            scale: animation,
            child: child,
          ),
          child: _controller.isRightDoorLock
              ? SvgPicture.asset(
                  "assets/icons/door_lock.svg",
                  key: ValueKey("lock"),
                )
              : SvgPicture.asset(
                  "assets/icons/door_unlock.svg",
                  key: ValueKey("unlock"),
                ),
        ),
      ),
    );
  }
}
