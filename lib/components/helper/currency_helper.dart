import 'package:flutter_money_formatter/flutter_money_formatter.dart';

class CurrencyHelper {
  static String currency(double ammount) {
    FlutterMoneyFormatter fmf = new FlutterMoneyFormatter(
        amount: ammount,
        settings: MoneyFormatterSettings(
            symbol: 'R\$',
            thousandSeparator: '.',
            decimalSeparator: ',',
            symbolAndNumberSeparator: ' ',
            fractionDigits: 2,
            compactFormatType: CompactFormatType.short));
    String currency = fmf.output.symbolOnLeft;
    return currency;
  }
}
