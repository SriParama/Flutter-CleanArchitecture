import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

double titleLargeFontSize = 20.0;
double titleMediumFontSize = 18.0;
double titleSmallFontSize = 16.0;

double bodyLargeFontSize = 14.0;
double bodyMediumFontSize = 13.0;
double bodySmallFontSize = 12.0;

double contentFontSize = 11.0;
String somethingError = 'Something went wrong...';
String sessionError = 'Session Expired...';
String LogoutSuccess = 'Logout Successfully';
String sendotpSuccess = 'OTP sent successfully';
String pwdResetSuccess = 'Password Reset successfully';
var rsFormat = NumberFormat.currency(
  // name: "",
  locale: 'en_IN',
  decimalDigits: 0,
  // change it to get decimal places
  symbol: '₹ ',
);
var rsMrkFormat = NumberFormat.currency(
  // name: "",
  locale: 'en_IN',
  decimalDigits: 0,
  symbol: '',
  // change it to get decimal places
);

String formatMrkNumber(int number) {
  if (number < 100000) {
    return rsMrkFormat.format(number); // Return as is if less than 1 lakh
  } else if (number >= 100000 && number < 10000000) {
    double lakhs = number / 100000;
    return '${lakhs.toStringAsFixed(2)} Lakhs';
  } else {
    double crores = number / 10000000;
    return '${crores.toStringAsFixed(2)} Crores';
  }
}

String formatNumber(int number) {
  if (number < 100000) {
    return rsFormat.format(number); // Return as is if less than 1 lakh
  } else if (number >= 100000 && number < 10000000) {
    double lakhs = number / 100000;
    return '${lakhs.toStringAsFixed(2)} Lakhs';
  } else {
    double crores = number / 10000000;
    return '${crores.toStringAsFixed(2)} Crores';
  }
}

class NoSpaceInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String trimmedNewValue = newValue.text.trim();
    if (trimmedNewValue.contains(' ')) {
      // If the new value contains a space, don't allow the change
      return oldValue;
    }
    return TextEditingValue(
        text: trimmedNewValue,
        selection: TextSelection.collapsed(offset: trimmedNewValue.length));
  }
}

class NoSpecialCharactersFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Remove special characters from the new value
    final sanitizedValue = newValue.text.replaceAll(RegExp(r'[^\w\s]'), '');
    return TextEditingValue(
      text: sanitizedValue,
      selection: newValue.selection,
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

extension StringExtension on String {
  bool panValidation() {
    return RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$').hasMatch(this);
  }
}

upiValidation(value) {
  final RegExp upiIdPattern = RegExp(r'^[a-zA-Z0-9_-]+@[\w]+[a-zA-Z_-]');
  if (value!.isEmpty) {
    return "";
  } else if (!upiIdPattern.hasMatch(value)) {
    return 'Invalid UPI ID';
  }
  return null;
}

validator(value) {
  {
    if (value!.isEmpty) {
      return "";
    }
    return null;
  }
}

var indRupeesFormat = NumberFormat.currency(
  // name: "",
  locale: 'en_IN',
  decimalDigits: 0,
  // change it to get decimal places
  symbol: '₹ ',
);
