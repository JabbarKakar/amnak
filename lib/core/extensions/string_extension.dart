import 'package:amnak/export.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  /// ex: Text ('US'. toFlag),
  String get toFlag {
    return (this).toUpperCase().replaceAllMapped(RegExp(r'[A-Z]'),
        (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397));
  }

  String toTitleCase() {
    try {
      return isEmpty
          ? this
          : replaceAll(RegExp(' +'), ' ')
              .replaceAll('_', ' ')
              .split(' ')
              .map((str) => str.capitalize())
              .join(' ');
    } catch (e) {
      Logger().i(e);
      return this;
    }
  }

  Text get text => Text(this);

  String formatContactNumber() {
    if (isEmpty || length < 9) {
      return "";
    }
    replaceAll(" ", "");
    int shiftNumberBy = 0;
    if (this[0] == '+') {
      shiftNumberBy = 1;
    }

    return (length > 9)
        ? "${substring(0, 3 + shiftNumberBy)} ${substring(3 + shiftNumberBy, 6 + shiftNumberBy)} ${substring(6 + shiftNumberBy, 9 + shiftNumberBy)} ${substring(9 + shiftNumberBy)}"
        : "${substring(0, 3 + shiftNumberBy)} ${substring(3 + shiftNumberBy, 6 + shiftNumberBy)} ${substring(6 + shiftNumberBy)}";
  }

  String maybeHandleOverflow({int? maxChars, String replacement = ''}) =>
      maxChars != null && length > maxChars
          ? replaceRange(maxChars, null, replacement)
          : this;
}

extension IsNullOrEmpty on String? {
  bool isNullOrEmpty() => (isNull || this!.isEmpty);
  bool get isNull => this == null || this == 'null';
  double get toDouble => double.tryParse(toString()) ?? 0.0;
  double? get toDoubleOrNull => double.tryParse(toString());
  int get toInt => int.tryParse(toString()) ?? 0;
  String orEmpty() => this ?? '';
  String orNa() => this ?? 'N/A';
  String orDash() => this ?? '-';

  String toFormattedDate() {
    return this == null
        ? ''
        : DateFormat.yMMMd().format(DateTime.parse(this!)).toString();
  }

  String toFormattedDateTime() {
    return this == null
        ? ''
        : '${DateFormat.yMMMd().format(DateTime.parse(this!))} ${DateFormat.Hms().format(DateTime.parse(this!))}';
  }
}

extension UrlExtensions on String {
  String extension() => path.extension(this);
  String fileNameWithoutExtensions() => path.basenameWithoutExtension(this);
  String fileNameWithExtensions() => path.basename(this);
  // bool isHttpURL() => Regex.httpUrl.hasMatch(this);
  bool get isImage => ['.png', '.jpeg', '.jpg'].contains(toLowerCase());
}
