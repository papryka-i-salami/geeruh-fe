// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class GeeColors {
  static final _primary = Color(0xFF43663D);
  static final _secondary = Color(0xFF663D58);
  static final _gray = Color(0xFF000000);

  static final primary1 = svModify(color: _primary, s: 0.40, v: 0.40);
  static final primary2 = svModify(color: _primary, s: 0.35, v: 0.60);
  static final primary3 = svModify(color: _primary, s: 0.30, v: 0.80);
  static final primary4 = svModify(color: _primary, s: 0.25, v: 0.90);
  static final primary5 = svModify(color: _primary, s: 0.15, v: 0.90);

  static final secondary1 = svModify(color: _secondary, s: 0.40, v: 0.40);
  static final secondary2 = svModify(color: _secondary, s: 0.35, v: 0.60);
  static final secondary3 = svModify(color: _secondary, s: 0.30, v: 0.80);
  static final secondary4 = svModify(color: _secondary, s: 0.25, v: 0.90);
  static final secondary5 = svModify(color: _secondary, s: 0.15, v: 0.90);

  static final gray1 = svModify(color: _gray, s: 0, v: 0.10);
  static final gray2 = svModify(color: _gray, s: 0, v: 0.20);
  static final gray3 = svModify(color: _gray, s: 0, v: 0.30);
  static final gray4 = svModify(color: _gray, s: 0, v: 0.40);
  static final gray5 = svModify(color: _gray, s: 0, v: 0.50);
  static final gray6 = svModify(color: _gray, s: 0, v: 0.60);
  static final gray7 = svModify(color: _gray, s: 0, v: 0.70);
  static final gray8 = svModify(color: _gray, s: 0, v: 0.80);
  static final gray9 = svModify(color: _gray, s: 0, v: 0.90);
  static final gray10 = svModify(color: _gray, s: 0, v: 0.95);

  static final red = Color(0xFF871B1B);
  static final orange = Color(0xFFCC8829);
  static final yellow = Color(0xFFCCB129);
  static final white = Color(0xFFFFFFFF);
  static final black = Color(0xFF000000);

  static Color svModify({required Color color, double s = 1, double v = 1}) {
    return HSVColor.fromColor(color).withSaturation(s).withValue(v).toColor();
  }
}

class GeeFont {
  static const String publicSansBlack = "PublicSans-Black";
  static const String publicSansBlackItalic = "PublicSans-BlackItalic";
  static const String publicSansBold = "PublicSans-Bold";
  static const String publicSansBoldItalic = "PublicSans-BoldItalic";
  static const String publicSansExtraBold = "PublicSans-ExtraBold";
  static const String publicSansExtraBoldItalic = "PublicSans-ExtraBoldItalic";
  static const String publicSansExtraLight = "PublicSans-ExtraLight";
  static const String publicSansExtraLightItalic =
      "PublicSans-ExtraLightItalic";
  static const String publicSansItalic = "PublicSans-Italic";
  static const String publicSansLight = "PublicSans-Light";
  static const String publicSansLightItalic = "PublicSans-LightItalic";
  static const String publicSansMedium = "PublicSans-Medium";
  static const String publicSansMediumItalic = "PublicSans-MediumItalic";
  static const String publicSansRegular = "PublicSans-Regular";
  static const String publicSansSemiBold = "PublicSans-SemiBold";
  static const String publicSansSemiBoldItalic = "PublicSans-SemiBoldItalic";
  static const String publicSansThin = "PublicSans-Thin";
  static const String publicSansThinItalic = "PublicSans-ThinItalic";
}

class GeeTextStyles {
  static const TextStyle heading1 = TextStyle(
    fontSize: 48,
    fontFamily: GeeFont.publicSansBold,
  );
  static const TextStyle heading2 = TextStyle(
    fontSize: 40,
    fontFamily: GeeFont.publicSansBold,
  );
  static const TextStyle heading3 = TextStyle(
    fontSize: 34,
    fontFamily: GeeFont.publicSansBold,
  );
  static const TextStyle heading4 = TextStyle(
    fontSize: 28,
    fontFamily: GeeFont.publicSansBold,
  );
  static const TextStyle heading5 = TextStyle(
    fontSize: 22,
    fontFamily: GeeFont.publicSansBold,
  );
  static const TextStyle heading6 = TextStyle(
    fontSize: 18,
    fontFamily: GeeFont.publicSansBold,
  );

  static const TextStyle paragraph1 = TextStyle(
    fontSize: 26,
    fontFamily: GeeFont.publicSansRegular,
  );
  static const TextStyle paragraph2 = TextStyle(
    fontSize: 20,
    fontFamily: GeeFont.publicSansRegular,
  );
  static const TextStyle paragraph3 = TextStyle(
    fontSize: 14,
    fontFamily: GeeFont.publicSansRegular,
  );
}

ThemeData geeruhThemeData() {
  return ThemeData(
      appBarTheme: AppBarTheme(color: GeeColors.primary1),
      scaffoldBackgroundColor: GeeColors.gray10,
      textTheme: TextTheme(
          bodyText1: GeeTextStyles.heading5.copyWith(color: GeeColors.gray2)));
}
