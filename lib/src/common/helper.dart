import 'package:intl/intl.dart';

// This extension is for converting country code to country flag image.
extension ConvertFlag on String {
  String get toFlag {
    return (this).toUpperCase().replaceAllMapped(
      RegExp(r'[A-Z]'),
      (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397),
    );
  }
}

String formatPrice(double value) {
  final formatter = NumberFormat("#,##0.00", "de_DE");
  return formatter.format(value);
}

String formatPriceWithoutDecimal(double value) {
  final formatter = NumberFormat("#,##0", "de_DE");
  return formatter.format(value);
}

String formatDate(DateTime date) {
  return "${date.day}/${date.month}/${date.year}";
}
