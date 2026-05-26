import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff8e4953),
      surfaceTint: Color(0xff8e4953),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffffd9dc),
      onPrimaryContainer: Color(0xff3b0713),
      secondary: Color(0xff765659),
      onSecondary: Color.fromARGB(255, 27, 21, 21),
      secondaryContainer: Color(0xffffd9dc),
      onSecondaryContainer: Color(0xff2c1518),
      tertiary: Color(0xff785830),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffffddb7),
      onTertiaryContainer: Color(0xff2a1700),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      surface: Color(0xfffff8f7),
      onSurface: Color(0xff22191a),
      onSurfaceVariant: Color(0xff524344),
      outline: Color(0xff847374),
      outlineVariant: Color(0xffd7c1c3),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff382e2f),
      inversePrimary: Color(0xffffb2bb),
      primaryFixed: Color(0xffffd9dc),
      onPrimaryFixed: Color(0xff3b0713),
      primaryFixedDim: Color(0xffffb2bb),
      onPrimaryFixedVariant: Color(0xff72333d),
      secondaryFixed: Color(0xffffd9dc),
      onSecondaryFixed: Color(0xff2c1518),
      secondaryFixedDim: Color(0xffe5bdc0),
      onSecondaryFixedVariant: Color(0xff5c3f42),
      tertiaryFixed: Color(0xffffddb7),
      onTertiaryFixed: Color(0xff2a1700),
      tertiaryFixedDim: Color(0xffe9bf8f),
      onTertiaryFixedVariant: Color(0xff5e411b),
      surfaceDim: Color(0xffe7d6d7),
      surfaceBright: Color(0xfffff8f7),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffff0f0),
      surfaceContainer: Color(0xfffceaea),
      surfaceContainerHigh: Color(0xfff6e4e5),
      surfaceContainerHighest: Color(0xfff0dedf),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff6d2f39),
      surfaceTint: Color(0xff8e4953),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffa95f69),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff583b3e),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff8e6c6f),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff593d18),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff906e44),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff8c0009),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffda342e),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffff8f7),
      onSurface: Color(0xff22191a),
      onSurfaceVariant: Color(0xff4e3f40),
      outline: Color(0xff6b5b5c),
      outlineVariant: Color(0xff887678),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff382e2f),
      inversePrimary: Color(0xffffb2bb),
      primaryFixed: Color(0xffa95f69),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff8c4751),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff8e6c6f),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff735457),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff906e44),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff75562e),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffe7d6d7),
      surfaceBright: Color(0xfffff8f7),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffff0f0),
      surfaceContainer: Color(0xfffceaea),
      surfaceContainerHigh: Color(0xfff6e4e5),
      surfaceContainerHighest: Color(0xfff0dedf),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff440e1a),
      surfaceTint: Color(0xff8e4953),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff6d2f39),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff331b1e),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff583b3e),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff331d00),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff593d18),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff4e0002),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff8c0009),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffff8f7),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff2d2122),
      outline: Color(0xff4e3f40),
      outlineVariant: Color(0xff4e3f40),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff382e2f),
      inversePrimary: Color(0xffffe6e8),
      primaryFixed: Color(0xff6d2f39),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff511924),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff583b3e),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff3f2629),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff593d18),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff402704),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffe7d6d7),
      surfaceBright: Color(0xfffff8f7),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffff0f0),
      surfaceContainer: Color(0xfffceaea),
      surfaceContainerHigh: Color(0xfff6e4e5),
      surfaceContainerHighest: Color(0xfff0dedf),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffb2bb),
      surfaceTint: Color(0xffffb2bb),
      onPrimary: Color(0xff561d27),
      primaryContainer: Color(0xff72333d),
      onPrimaryContainer: Color(0xffffd9dc),
      secondary: Color(0xffe5bdc0),
      onSecondary: Color(0xff43292c),
      secondaryContainer: Color(0xff5c3f42),
      onSecondaryContainer: Color(0xffffd9dc),
      tertiary: Color(0xffe9bf8f),
      onTertiary: Color(0xff442b07),
      tertiaryContainer: Color(0xff5e411b),
      onTertiaryContainer: Color(0xffffddb7),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff1a1112),
      onSurface: Color(0xfff0dedf),
      onSurfaceVariant: Color(0xffd7c1c3),
      outline: Color(0xff9f8c8d),
      outlineVariant: Color(0xff524344),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xfff0dedf),
      inversePrimary: Color(0xff8e4953),
      primaryFixed: Color(0xffffd9dc),
      onPrimaryFixed: Color(0xff3b0713),
      primaryFixedDim: Color(0xffffb2bb),
      onPrimaryFixedVariant: Color(0xff72333d),
      secondaryFixed: Color(0xffffd9dc),
      onSecondaryFixed: Color(0xff2c1518),
      secondaryFixedDim: Color(0xffe5bdc0),
      onSecondaryFixedVariant: Color(0xff5c3f42),
      tertiaryFixed: Color(0xffffddb7),
      onTertiaryFixed: Color(0xff2a1700),
      tertiaryFixedDim: Color(0xffe9bf8f),
      onTertiaryFixedVariant: Color(0xff5e411b),
      surfaceDim: Color(0xff1a1112),
      surfaceBright: Color(0xff413737),
      surfaceContainerLowest: Color(0xff140c0d),
      surfaceContainerLow: Color(0xff22191a),
      surfaceContainer: Color(0xff261d1e),
      surfaceContainerHigh: Color(0xff312828),
      surfaceContainerHighest: Color(0xff3d3233),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffb8c0),
      surfaceTint: Color(0xffffb2bb),
      onPrimary: Color(0xff33030e),
      primaryContainer: Color(0xffc97a84),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffeac1c4),
      onSecondary: Color(0xff261013),
      secondaryContainer: Color(0xffac888b),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffeec393),
      onTertiary: Color(0xff231300),
      tertiaryContainer: Color(0xffaf8a5e),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffbab1),
      onError: Color(0xff370001),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff1a1112),
      onSurface: Color(0xfffff9f9),
      onSurfaceVariant: Color(0xffdbc6c7),
      outline: Color(0xffb29e9f),
      outlineVariant: Color(0xff917f80),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xfff0dedf),
      inversePrimary: Color(0xff73343e),
      primaryFixed: Color(0xffffd9dc),
      onPrimaryFixed: Color(0xff2c0009),
      primaryFixedDim: Color(0xffffb2bb),
      onPrimaryFixedVariant: Color(0xff5d222d),
      secondaryFixed: Color(0xffffd9dc),
      onSecondaryFixed: Color(0xff200b0e),
      secondaryFixedDim: Color(0xffe5bdc0),
      onSecondaryFixedVariant: Color(0xff4a2f32),
      tertiaryFixed: Color(0xffffddb7),
      onTertiaryFixed: Color(0xff1c0e00),
      tertiaryFixedDim: Color(0xffe9bf8f),
      onTertiaryFixedVariant: Color(0xff4b310c),
      surfaceDim: Color(0xff1a1112),
      surfaceBright: Color(0xff413737),
      surfaceContainerLowest: Color(0xff140c0d),
      surfaceContainerLow: Color(0xff22191a),
      surfaceContainer: Color(0xff261d1e),
      surfaceContainerHigh: Color(0xff312828),
      surfaceContainerHighest: Color(0xff3d3233),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xfffff9f9),
      surfaceTint: Color(0xffffb2bb),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffffb8c0),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xfffff9f9),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffeac1c4),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xfffffaf7),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffeec393),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xfffff9f9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffbab1),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff1a1112),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xfffff9f9),
      outline: Color(0xffdbc6c7),
      outlineVariant: Color(0xffdbc6c7),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xfff0dedf),
      inversePrimary: Color(0xff4e1621),
      primaryFixed: Color(0xffffdfe1),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffffb8c0),
      onPrimaryFixedVariant: Color(0xff33030e),
      secondaryFixed: Color(0xffffdfe1),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffeac1c4),
      onSecondaryFixedVariant: Color(0xff261013),
      tertiaryFixed: Color(0xffffe2c3),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffeec393),
      onTertiaryFixedVariant: Color(0xff231300),
      surfaceDim: Color(0xff1a1112),
      surfaceBright: Color(0xff413737),
      surfaceContainerLowest: Color(0xff140c0d),
      surfaceContainerLow: Color(0xff22191a),
      surfaceContainer: Color(0xff261d1e),
      surfaceContainerHigh: Color(0xff312828),
      surfaceContainerHighest: Color(0xff3d3233),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        textTheme: textTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        ),
        scaffoldBackgroundColor: colorScheme.surface,
        canvasColor: colorScheme.surface,
      );

  List<ExtendedColor> get extendedColors => [];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
