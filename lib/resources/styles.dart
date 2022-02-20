import 'package:flex_color_scheme/flex_color_scheme.dart';

class Styles {
  static const scheme = FlexScheme.aquaBlue;
  static final darkTheme = FlexColorScheme.dark(scheme: scheme).toTheme;
  static final defaultTheme = FlexColorScheme.light(scheme: scheme).toTheme;
}
