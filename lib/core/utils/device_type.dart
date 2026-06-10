import 'package:flutter/material.dart';

enum DeviceType { mobile, tablet }

extension DeviceTypeContext on BuildContext {
  DeviceType get deviceType {
    return MediaQuery.of(this).size.shortestSide >= 600
        ? DeviceType.tablet
        : DeviceType.mobile;
  }

  bool get isTablet => deviceType == DeviceType.tablet;
}
