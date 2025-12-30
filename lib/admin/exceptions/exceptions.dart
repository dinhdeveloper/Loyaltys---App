
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class ThousandsFormatter extends TextInputFormatter {
  final NumberFormat _formatter = NumberFormat('#,###');

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    // bỏ dấu phẩy
    final cleanText = newValue.text.replaceAll(',', '');

    // chỉ cho số
    final intValue = int.tryParse(cleanText);
    if (intValue == null) {
      return oldValue;
    }

    final newText = _formatter.format(intValue);

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}


class UpperCaseFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    // Không làm gì nếu text giống nhau
    if (newValue.text == oldValue.text) {
      return newValue;
    }

    final upper = newValue.text.toUpperCase();

    return TextEditingValue(
      text: upper,
      selection: newValue.selection,
    );
  }
}

String convertToApiKey(String input) {
  const Map<String, String> _vnMap = {
    'à':'a','á':'a','ạ':'a','ả':'a','ã':'a',
    'â':'a','ầ':'a','ấ':'a','ậ':'a','ẩ':'a','ẫ':'a',
    'ă':'a','ằ':'a','ắ':'a','ặ':'a','ẳ':'a','ẵ':'a',
    'è':'e','é':'e','ẹ':'e','ẻ':'e','ẽ':'e',
    'ê':'e','ề':'e','ế':'e','ệ':'e','ể':'e','ễ':'e',
    'ì':'i','í':'i','ị':'i','ỉ':'i','ĩ':'i',
    'ò':'o','ó':'o','ọ':'o','ỏ':'o','õ':'o',
    'ô':'o','ồ':'o','ố':'o','ộ':'o','ổ':'o','ỗ':'o',
    'ơ':'o','ờ':'o','ớ':'o','ợ':'o','ở':'o','ỡ':'o',
    'ù':'u','ú':'u','ụ':'u','ủ':'u','ũ':'u',
    'ư':'u','ừ':'u','ứ':'u','ự':'u','ử':'u','ữ':'u',
    'ỳ':'y','ý':'y','ỵ':'y','ỷ':'y','ỹ':'y',
    'đ':'d',
  };

  // 1. Bỏ dấu
  String noAccent = input.split('').map((c) => _vnMap[c.toLowerCase()] ?? c).join();

  // 2. Viết hoa
  noAccent = noAccent.toUpperCase();

  // 3. Khoảng trắng → '_'
  noAccent = noAccent.replaceAll(' ', '_');

  // 4. Chỉ giữ A-Z, 0-9 và '_'
  noAccent = noAccent.replaceAll(RegExp(r'[^A-Z0-9_]'), '');

  return noAccent;
}



class CapitalizeFormatter extends TextInputFormatter {
  final bool eachWord; // true: viết hoa đầu mỗi từ, false: chỉ viết hoa chữ đầu tiên

  CapitalizeFormatter({this.eachWord = false});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    String text = newValue.text;
    if (text.isEmpty) return newValue;

    String transformed;
    if (eachWord) {
      // Viết hoa đầu mỗi từ
      transformed = text
          .split(' ')
          .map((word) => word.isEmpty
          ? ''
          : word[0].toUpperCase() + word.substring(1))
          .join(' ');
    } else {
      // Chỉ viết hoa chữ cái đầu tiên
      transformed = text[0].toUpperCase() + text.substring(1);
    }

    return TextEditingValue(
      text: transformed,
      selection: TextSelection.collapsed(offset: transformed.length),
    );
  }
}
