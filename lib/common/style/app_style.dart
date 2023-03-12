import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppTheme {
  static ThemeData theme = FlexThemeData.light(
    useMaterial3: true,

    scheme: FlexScheme.espresso,
    surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
    blendLevel: 9,
    subThemesData: const FlexSubThemesData(
      blendOnLevel: 10,
      blendOnColors: false,
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    // To use the playground font, add GoogleFonts package and uncomment
    fontFamily: GoogleFonts.notoSans().fontFamily,
  );

  static ThemeData darkTheme = FlexThemeData.dark(
    useMaterial3: true,

    scheme: FlexScheme.espresso,
    surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
    blendLevel: 15,
    subThemesData: const FlexSubThemesData(
      blendOnLevel: 20,
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    // To use the Playground font, add GoogleFonts package and uncomment
    fontFamily: GoogleFonts.notoSans().fontFamily,
  );
}
 // TODO(Kseniya): Удалить закомментированное если оно уже не потребуется

// import 'package:flex_color_scheme/flex_color_scheme.dart'; 
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// abstract class AppTheme {
//   static ThemeData theme = FlexThemeData.light(
//     useMaterial3: true,
//     colors: const FlexSchemeColor(
//       primary: Color(0xff004881),
//       primaryContainer: Color(0xffd0e4ff),
//       secondary: Color(0xffac3306),
//       secondaryContainer: Color(0xffffdbcf),
//       tertiary: Color(0xff006875),
//       tertiaryContainer: Color(0xff95f0ff),
//       appBarColor: Color(0xffffdbcf),
//       error: Color(0xffb00020),
//     ),
//     surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
//     blendLevel: 9,
//     subThemesData: const FlexSubThemesData(
//       blendOnLevel: 10,
//       blendOnColors: false,
//     ),
//     visualDensity: FlexColorScheme.comfortablePlatformDensity,
//     // To use the playground font, add GoogleFonts package and uncomment
//     fontFamily: GoogleFonts.notoSans().fontFamily,
//   );

//   static ThemeData darkTheme = FlexThemeData.dark(
//     useMaterial3: true,

//     colors: const FlexSchemeColor(
//       primary: Color(0xff9fc9ff),
//       primaryContainer: Color(0xff00325b),
//       secondary: Color(0xffffb59d),
//       secondaryContainer: Color(0xff872100),
//       tertiary: Color(0xff86d2e1),
//       tertiaryContainer: Color(0xff004e59),
//       appBarColor: Color(0xff872100),
//       error: Color(0xffcf6679),
//     ),
//     surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
//     blendLevel: 15,
//     subThemesData: const FlexSubThemesData(
//       blendOnLevel: 20,
//     ),
//     visualDensity: FlexColorScheme.comfortablePlatformDensity,
//     // To use the Playground font, add GoogleFonts package and uncomment
//     fontFamily: GoogleFonts.notoSans().fontFamily,
//   );
// }
