mixin FormatPrice {
  String formatWithDecimal(value) {
    if (value is double && value == 0) {
      return '0';
    }
    String temp = value.toStringAsFixed(2);
    temp = temp.replaceAll('.', ',');
    if (temp.length >= 7) {
      temp = temp.substring(0, temp.length - 6) + '.' + temp.substring(temp.length - 6, temp.length);
    }

    return temp;
  }

  String formatWithoutDecimal(value) {
    if (value is double && value == 0) {
      return '0';
    }
    String temp = value.toStringAsFixed(0);
    if (temp.length >= 4) {
      temp = temp.substring(0, temp.length - 3) + '.' + temp.substring(temp.length - 3, temp.length);
    }
    return temp;
  }

  double formatDouble(String value) {
    if (value == '') return 0;
    return double.parse(value.replaceAll('.', '').replaceAll(',', '')) / 100;
  }
}
