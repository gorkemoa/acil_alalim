import 'package:flutter/widgets.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double defaultSize;
  static late Orientation orientation;

  // Scaling Cap: iPhone 13 Dimensions
  static const double _designWidth = 390.0;
  static const double _designHeight = 844.0;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);

    // Scaling Cap implementation
    // If device is larger than standard, we can cap effective width/height or just use them for scaling logic
    // README: "Bu sınırın üzerindeki cihazlarda öğeler büyümez"
    double currentWidth = _mediaQueryData.size.width;
    double currentHeight = _mediaQueryData.size.height;

    // Use the smaller of actual or design for scaling reference
    // (This usually means on tablets it won't scale up hugely, but keeps phone proportions)
    // However, adhering strictly to "items don't grow" means we might clamp the scaling factor.

    screenWidth = currentWidth;
    screenHeight = currentHeight;
    orientation = _mediaQueryData.orientation;
  }

  // Get the proportionate height as per screen size
  static double getProportionateScreenHeight(double inputHeight) {
    // Current height / Design height
    double screenHeightToUse = screenHeight > _designHeight
        ? _designHeight
        : screenHeight;
    return (inputHeight / _designHeight) * screenHeightToUse;
  }

  // Get the proportionate width as per screen size
  static double getProportionateScreenWidth(double inputWidth) {
    double screenWidthToUse = screenWidth > _designWidth
        ? _designWidth
        : screenWidth;
    return (inputWidth / _designWidth) * screenWidthToUse;
  }
}
