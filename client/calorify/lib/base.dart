import 'package:animations/animations.dart';
import 'package:calorify/app_info.dart';
import 'package:calorify/home.dart';
import 'package:calorify/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Base extends StatefulWidget {
  const Base({super.key});

  @override
  State<Base> createState() => _BaseState();
}

class _BaseState extends State<Base> {
  int pageIndex = 1;

  @override
  void initState() {
    super.initState();
    toggleButtonState(pageIndex);
  }

  final pages = [const AppInfo(), const Home(), const Settings()];

  List<bool> buttonStates = [false, false, false];

  void toggleButtonState(int index) {
    setState(() {
      pageIndex = index;
      for (int i = 0; i < buttonStates.length; i++) {
        if (i == index) {
          buttonStates[i] = !buttonStates[i];
        } else {
          buttonStates[i] = false;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const primaryFilter = ColorFilter.mode(Color(0xFFEA3C3A), BlendMode.srcIn);
    const grayFilter = ColorFilter.mode(Colors.grey, BlendMode.srcIn);

    return MaterialApp(
        home: Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomLeft,
        stops: [
          0.1,
          0.8,
        ],
        colors: [
          Color(0xFFF6B22D),
          Color(0xFFEA3C3A),
        ],
      )),
      child: Stack(
        fit: StackFit.loose,
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          SizedBox(
              height: double.infinity,
              child: PageTransitionSwitcher(
                  duration: const Duration(milliseconds: 500),
                  transitionBuilder: (Widget child, Animation<double> animation,
                      Animation<double> secondaryAnimation) {
                    return FadeThroughTransition(
                        animation: animation,
                        secondaryAnimation: secondaryAnimation,
                        fillColor: Colors.transparent,
                        child: child);
                  },
                  child: pages[pageIndex])),
          Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF4E1413).withOpacity(0.5),
                    spreadRadius: 0,
                    blurRadius: 25,
                  ),
                ],
              ),
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                IconButton(
                  color: buttonStates[0] ? theme.primaryColor : Colors.grey,
                  icon: buttonStates[0]
                      ? SvgPicture.asset('assets/icons/info.svg',
                          colorFilter: primaryFilter)
                      : SvgPicture.asset('assets/icons/info-outline.svg',
                          colorFilter: grayFilter),
                  onPressed: () {
                    toggleButtonState(0);
                  },
                ),
                const SizedBox(width: 20),
                IconButton(
                  color: buttonStates[1] ? theme.primaryColor : Colors.grey,
                  icon: buttonStates[1]
                      ? SvgPicture.asset('assets/icons/home.svg',
                          colorFilter: primaryFilter)
                      : SvgPicture.asset('assets/icons/home-outline.svg',
                          colorFilter: grayFilter),
                  onPressed: () {
                    toggleButtonState(1);
                  },
                ),
                const SizedBox(width: 20),
                IconButton(
                  color: buttonStates[2] ? theme.primaryColor : Colors.grey,
                  icon: buttonStates[2]
                      ? SvgPicture.asset('assets/icons/settings.svg',
                          colorFilter: primaryFilter)
                      : SvgPicture.asset('assets/icons/settings-outline.svg',
                          colorFilter: grayFilter),
                  onPressed: () {
                    toggleButtonState(2);
                  },
                ),
              ]))
        ],
      ),
    ));
  }
}
