import 'package:intl/intl.dart';

String convertDate(String input) {
  final date = DateFormat('d/M/yy').parse(input);
  return DateFormat('d MMM yyyy').format(date);
}