import 'size_config.dart';

class SizeTokens {
  // Padding & Margin
  static double get k4 => SizeConfig.getProportionateScreenWidth(4);
  static double get k8 => SizeConfig.getProportionateScreenWidth(8);
  static double get k12 => SizeConfig.getProportionateScreenWidth(12);
  static double get k16 => SizeConfig.getProportionateScreenWidth(16);
  static double get k20 => SizeConfig.getProportionateScreenWidth(20);
  static double get k24 => SizeConfig.getProportionateScreenWidth(24);
  static double get k32 => SizeConfig.getProportionateScreenWidth(32);
  static double get k48 => SizeConfig.getProportionateScreenWidth(48);

  // Border Radius
  static double get r4 => SizeConfig.getProportionateScreenWidth(4);
  static double get r8 => SizeConfig.getProportionateScreenWidth(8);
  static double get r12 => SizeConfig.getProportionateScreenWidth(12);
  static double get r16 => SizeConfig.getProportionateScreenWidth(16);
  static double get r24 => SizeConfig.getProportionateScreenWidth(24);
  static double get rCircle => SizeConfig.getProportionateScreenWidth(1000);

  // Icon Sizes
  static double get iconSmall => SizeConfig.getProportionateScreenWidth(16);
  static double get iconMedium => SizeConfig.getProportionateScreenWidth(24);
  static double get iconLarge => SizeConfig.getProportionateScreenWidth(32);

  // Text Sizes (Note: Font sizes usually scale with height or maintain logic)
  static double get fontXS => SizeConfig.getProportionateScreenWidth(10);
  static double get fontS => SizeConfig.getProportionateScreenWidth(12);
  static double get fontM => SizeConfig.getProportionateScreenWidth(14);
  static double get fontL => SizeConfig.getProportionateScreenWidth(16);
  static double get fontXL => SizeConfig.getProportionateScreenWidth(18);
  static double get fontXXL => SizeConfig.getProportionateScreenWidth(24);
  static double get fontHeader => SizeConfig.getProportionateScreenWidth(32);
}
