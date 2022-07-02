import 'dart:ui';
import 'package:flutter/foundation.dart';

enum DeviceScreenType {
  mobileS,
  mobile,
  mobileL,
  mobileXl,
  tabletS,
  tablet,
  tabletL,
  tabletXL,
  desktopS,
  desktop,
  desktopL,
  desktopXL,
  watch
}

///Device Helper is class for getting device type based on Width of screen
class DeviceScreenHelper {
  var desktopExtraLarge = 4096.0;
  var desktopLarge = 3840.0;
  var desktopNormal = 1920.0;
  var desktopSmall = 950.0;
  var tabletExtraLarge = 900.0;
  var tabletLarge = 850.0;
  var tabletNormal = 768.0;
  var tabletSmall = 600.0;
  var mobileExtraExtraLarge = 576.0;
  var mobileExtraLarge = 480.0;
  var mobileLarge = 414.0;
  var mobileNormal = 380.0;
  var mobileSmall = 320.0;
  var watch = 300.0;

  var ipadPro12_9 = 1024.0;
  var ipadPro_3Gen = 834.0;
  var ipadAir_4Gen = 820.0;
  var iPad_9Gen = 810.0;
  var iPadPro97 = 768.0;
  var iPadMini_6Gen = 744.0;

  double getSizeBaseOnDeviceType(DeviceScreenType screenType) {
    switch (screenType) {
      case DeviceScreenType.watch:
        return watch;
      case DeviceScreenType.tablet:
        return tabletNormal;
      case DeviceScreenType.desktop:
        return desktopNormal;
      default:
        return mobileNormal;
    }
  }

  ///Get Type of device, will return is device a Desktop, Tablet or Phone
  ///Use case: When you need to create different layout for Tablet and Phone
  DeviceScreenType getDeviceType(Size size) {
    var deviceWidth = size.shortestSide;

    if (kIsWeb) {
      deviceWidth = size.width;
    }

    if (deviceWidth >= desktopSmall) {
      return DeviceScreenType.desktop;
    }

    if (deviceWidth >= tabletSmall) {
      return DeviceScreenType.tablet;
    }

    if (deviceWidth < watch) {
      return DeviceScreenType.watch;
    }

    return DeviceScreenType.mobile;
  }

  ///Get more spesific size of screen of device.
  ///Use case: When you need pick different resolution of picture based on device size
  DeviceScreenType getRefinedDeviceType(Size size) {
    var deviceScreenType = getDeviceType(size);
    var deviceWidth = size.shortestSide;

    // Desktop
    if (deviceScreenType == DeviceScreenType.desktop) {
      if (deviceWidth >= desktopExtraLarge) {
        return DeviceScreenType.desktopXL;
      } else if (deviceWidth >= desktopLarge) {
        return DeviceScreenType.desktopL;
      } else if (deviceWidth >= desktopSmall) {
        return DeviceScreenType.desktopS;
      } else {
        return DeviceScreenType.desktop;
      }
    }

    // Tablet
    if (deviceScreenType == DeviceScreenType.tablet) {
      if (deviceWidth >= tabletExtraLarge) {
        return DeviceScreenType.tabletXL;
      } else if (deviceWidth >= tabletLarge) {
        return DeviceScreenType.tabletL;
      } else if (deviceWidth >= tabletSmall) {
        return DeviceScreenType.tabletS;
      } else {
        return DeviceScreenType.tablet;
      }
    }

    // Mobile
    if (deviceScreenType == DeviceScreenType.mobile) {
      if (deviceWidth >= mobileExtraLarge) {
        return DeviceScreenType.mobileXl;
      } else if (deviceWidth >= mobileLarge) {
        return DeviceScreenType.mobileL;
      } else if (deviceWidth >= mobileSmall) {
        return DeviceScreenType.mobileS;
      } else {
        return DeviceScreenType.mobile;
      }
    }

    return DeviceScreenType.watch;
  }
}
