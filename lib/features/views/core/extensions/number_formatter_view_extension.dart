import 'package:intl/intl.dart';

extension NumberFormatterForViews on int {
  String toCompactFormatForViews() {

    final formatter = NumberFormat('#,###', 'en_US');

    return formatter.format(this).replaceAll(',', '.');
  }
}