// import 'package:flutter/material.dart';

// class ContinuosFadeInFadeOut extends StatelessWidget {

//   @override
//   Widget build(BuildContext context) {
//     return new Center(),
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class ContinuosFadeInFadeOut extends StatefulWidget {
  _ContinuosFadeInFadeOutState _continuosFadeInFadeOutState =
      new _ContinuosFadeInFadeOutState();
  _ContinuosFadeInFadeOutState createState() => _continuosFadeInFadeOutState;

  void stopAnimation() {
    return _continuosFadeInFadeOutState._stopAnimation();
  }
}

class _ContinuosFadeInFadeOutState extends State<ContinuosFadeInFadeOut>
    with TickerProviderStateMixin {
  IconData icon = Icons.mic;
  double size = 20.0;
  MaterialColor color = Colors.blue;

  AnimationController controller;
  Animation<double> animation;
  bool runAnimation = true;

  Future<void> _playAnimation() async {
    runAnimation = true;
    while (runAnimation) {
      try {
        await controller.forward();
        await controller.reverse();
      } on Error {}
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  _stopAnimation() {
    setState(() {
      runAnimation = false;
    });
  }

  initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 800), vsync: this);

    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    _playAnimation();
  }

  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: FadeTransition(
            opacity: animation,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(
                this.icon,
                size: this.size,
                color: this.color,
              )
            ])));
  }
}
