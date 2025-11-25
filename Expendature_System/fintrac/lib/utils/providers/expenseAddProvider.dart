import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ExpenseAdd {
  final double? amount;
  final String description;
  final String category;
  final DateTime date;

  ExpenseAdd({
    required this.amount,
    required this.description,
    required this.category,
    required this.date,
  });

  Map<String, dynamic> toJson() => {
        'amount': amount,
        'description': description,
        'category': category,
        'date': date.toIso8601String(),
      };

  @override
  String toString() =>
      'ExpenseAdd(amount: $amount, description: $description, category: $category, date: $date)';
}


/// Simple API client for expenses
class ExpenseApi {
  final Uri baseUri;
  final Map<String, String> defaultHeaders;

  ExpenseApi({
    required String baseUrl,
    Map<String, String>? defaultHeaders,
  })  : baseUri = Uri.parse(baseUrl),
        defaultHeaders = defaultHeaders ??
            {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            };

  Future<Map<String, dynamic>> postExpenseJson(ExpenseAdd expense) async {
    final uri = baseUri.replace(path: '${baseUri.path}/expenses'.replaceAll('//', '/'));
    final body = jsonEncode(expense.toJson());

    final resp = await http.post(uri, headers: defaultHeaders, body: body);

    if (resp.statusCode >= 200 && resp.statusCode < 300) {
      if (resp.body.isEmpty) return {};
      return jsonDecode(resp.body) as Map<String, dynamic>;
    } else {
      
      throw HttpException('Failed to post expense: ${resp.statusCode} ${resp.reasonPhrase}\n${resp.body}');
    }
  }
}
