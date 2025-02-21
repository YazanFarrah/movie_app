import 'dart:ui';

class ColorUtils {
  static const Color primaryColor = Color(0xFF6949FF);

static Color hexToColor(String hexColor) {
    // Remove the '#' if present
    hexColor = hexColor.replaceAll('#', '');

    // Add 'FF' for full opacity if only RGB values are provided
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }

    // Parse the color value and use Color.fromARGB
    try {
      final int colorInt = int.parse(hexColor, radix: 16);
      return Color(colorInt);
    } catch (e) {
      // Return a default color if parsing fails
      return primaryColor;
    }
  }
}
