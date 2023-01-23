import 'package:flutter/material.dart';

import '../../presentation/animations/fade_animation.dart';

extension WidgetExtension on Widget {
  Widget fadeAnimation(double delay) {
    return FadeAnimation(delay: delay, child: this);
  }
}
